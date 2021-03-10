#tag Class
Protected Class RequestHandler
	#tag CompatibilityFlags = API2Only and ( ( TargetConsole and ( Target64Bit ) ) or ( TargetWeb and ( Target64Bit ) ) or ( TargetDesktop and ( Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) )
	#tag Method, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetConsole and (Target64Bit)) or  (TargetWeb and (Target64Bit)) or  (TargetDesktop and (Target64Bit)) or  (TargetIOS and (Target64Bit)) )
		Sub Constructor(Request As AloeXWS.Request, Response As AloeXWS.Response)
		  // Store the request and response as properties.
		  Self.Request = Request
		  Self.Response = Response
		  
		  // Prepare the database.
		  DatabasePrepare
		  
		  // If the connection to the database failed...
		  If Response.Status <> 200 Then
		    Return
		  End If
		  
		  // Authenticate the request.
		  RequestAuthenticate
		  
		  // If the authentication failed...
		  If Response.Status <> 200 Then
		    Return
		  End If
		  
		  // If no resource (table) was specified...
		  If Request.PathComponents.Count < 2 Then
		    Response.Status = 404
		    Response.Headers.Value( "X-Error" ) = "No resource specified."
		    Return
		  End If
		  
		  // Route the request.
		  RequestRoute
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetConsole and (Target64Bit)) or  (TargetWeb and (Target64Bit)) or  (TargetDesktop and (Target64Bit)) or  (TargetIOS and (Target64Bit)) )
		Sub DatabasePrepare()
		  // Create a folderitem that points to the database file.
		  Dim DatabaseFile As  FolderItem = SpecialFolder.Desktop.Child("drummers.sqlite")
		  
		  // If the database file doesn't exist...
		  If DatabaseFile.Exists = False Then
		    Response.Status = 500
		    Response.Headers.Value( "X-Error" ) = "Database file does not exist."
		    Return
		  End If
		  
		  // Create a new database instance.
		  Database = New SQLiteDatabase
		  
		  // Assign the database file to the database.
		  Database.DatabaseFile = DatabaseFile
		  
		  // If connecting to the database fails...
		  If Database.Connect = False Then
		    Response.Status = 500
		    Response.Headers.Value( "X-Error" ) = "Could not connect to the database."
		    Return
		  End If
		  
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetConsole and (Target64Bit)) or  (TargetWeb and (Target64Bit)) or  (TargetDesktop and (Target64Bit)) or  (TargetIOS and (Target64Bit)) )
		Sub DrummersDelete()
		  
		  
		  
		  
		  Dim Payload As JSONItem
		  Dim SQL As String
		  Dim PS As SQLitePreparedStatement
		  Dim Records As RecordSet
		  
		  // If no record ID was specified...
		  If Request.PathComponents.Count <> 3 Then
		    Response.Status = 400
		    Response.Headers.Value( "X-Error" ) = "Resource ID is missing."
		    Return 
		  End If
		  
		  // Get the ID of the record being requested.
		  Dim RecordID As String = Request.PathComponents(2)
		  
		  // If the record ID is not an integer...
		  If IsInteger( RecordID ) = False Then
		    Response.Status = 400
		    Response.Headers.Value( "X-Error" ) = "Resource ID must be an integer."
		    Return 
		  End If
		  
		  // Get the record.
		  SQL = "SELECT * FROM Drummers WHERE Drummer_ID = ?"
		  PS = Database.Prepare( SQL )
		  PS.Bind( 0, RecordID, PS.SQLITE_INTEGER )
		  Records = PS.SQLSelect
		  
		  // If no record was returned...
		  If Records.RecordCount = 0 Then
		    Response.Status = 404
		    Response.Headers.Value( "X-Error" ) = "Invalid RecordID specified."
		    Return 
		  End If
		  
		  // Create the statement and bind variables.
		  SQL = "DELETE FROM Drummers WHERE Drummer_ID = ?"
		  PS = Database.Prepare( SQL )
		  PS.Bind( 0, RecordID, PS.SQLITE_INTEGER )
		  
		  // Execute the statement.
		  PS.SQLExecute
		  
		  // Set the "No Content" response status code.
		  Response.Status = 204
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetConsole and (Target64Bit)) or  (TargetWeb and (Target64Bit)) or  (TargetDesktop and (Target64Bit)) or  (TargetIOS and (Target64Bit)) )
		Sub DrummersGet()
		  
		  
		  
		  Dim SQL As String
		  Dim PS As SQLitePreparedStatement
		  
		  // If a specific record was requested...
		  If Request.PathComponents.Count = 3 Then
		    
		    // Get the ID of the record being requested.
		    Dim RecordID As String = Request.PathComponents(2)
		    
		    // If the record ID is not an integer...
		    If IsInteger( RecordID ) = False Then
		      Response.Status = 400
		      Response.Headers.Value( "X-Error" ) = "Resource ID must be an integer."
		      Return 
		    End If
		    
		    // Create the statement and bind variables.
		    SQL = "SELECT * FROM Drummers WHERE Drummer_ID = ?"
		    PS = Database.Prepare( SQL )
		    PS.Bind( 0, RecordID, PS.SQLITE_INTEGER )
		    
		  Else
		    
		    // Create the statement.
		    SQL = "SELECT * FROM Drummers ORDER BY Votes DESC"
		    PS = Database.Prepare( SQL )
		    
		  End If
		  
		  // Perform the query.
		  Dim Records As RecordSet = PS.SQLSelect
		  
		  // If no records were returned...
		  If Records.RecordCount = 0 Then
		    Response.Status = 404
		    Response.Headers.Value( "X-Error" ) = "No records found."
		    Return 
		  End If
		  
		  // Convert the recordset to a JSON object.
		  Dim Drummers As JSONItem = RecordSetToJSONItem( Records ) 
		  
		  // Set the response content to a decoded version of the JSON object.
		  Response.Content = Drummers.ToString
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetConsole and (Target64Bit)) or  (TargetWeb and (Target64Bit)) or  (TargetDesktop and (Target64Bit)) or  (TargetIOS and (Target64Bit)) )
		Sub DrummersPost()
		  
		  
		  
		  
		  Dim Payload As JSONItem
		  Dim SQL As String
		  Dim PS As SQLitePreparedStatement
		  Dim Records As RecordSet
		  
		  // Try to convert the request body to JSON.
		  Try
		    Payload = New JSONItem( Request.Body )
		  Catch JSONException
		    Response.Status = 400
		    Response.Headers.Value( "X-Error" ) = "Unable to convert the payload to JSON."
		    Return
		  End Try
		  
		  
		  // Validate the request.
		  If ( ( Payload.HasName( "DrummerName" ) = False ) or ( Trim( Payload.Value( "DrummerName" ) ) = "" ) ) Then
		    Response.Status = 400
		    Response.Headers.Value( "X-Error" ) = "Missing value for DrummerName."
		    Return
		  End If
		  If Payload.HasName( "Votes" ) Then
		    If IsInteger( Payload.Value( "Votes" ) ) = False Then
		      Response.Status = 400
		      Response.Headers.Value( "X-Error" ) = "Value for Votes must be an integer."
		      Return
		    End If
		  End If
		  
		  // Check for duplicates...
		  SQL = "SELECT * FROM Drummers WHERE Drummer_Name = ?"
		  PS = Database.Prepare( SQL )
		  PS.Bind( 0, Trim( Payload.Value( "DrummerName" ) ), PS.SQLITE_TEXT )
		  Records = PS.SQLSelect
		  If Records.RecordCount > 0 Then
		    Response.Status = 400
		    Response.Headers.Value( "X-Error" ) = "A drummer with that name already exists."
		    Return 
		  End If
		  
		  
		  // Create the statement and bind variables.
		  SQL = "INSERT INTO Drummers ( Drummer_Name, Band_Name, Votes, URL ) Values ( ?, ?, ?, ? )"
		  PS = Database.Prepare( SQL )
		  PS.Bind( 0, Trim( Payload.Value( "DrummerName" ) ), PS.SQLITE_TEXT )
		  If Payload.HasName( "BandName" ) Then
		    PS.Bind( 1, Trim( Payload.Value( "BandName" ) ), PS.SQLITE_TEXT )
		  Else
		    PS.Bind( 1, Nil, PS.SQLITE_NULL )
		  End If
		  If Payload.HasName( "Votes" ) Then
		    PS.Bind( 2, Trim( Payload.Value( "Votes" ) ), PS.SQLITE_INTEGER )
		  Else
		    PS.Bind( 2, Nil, PS.SQLITE_NULL )
		  End If
		  If Payload.HasName( "URL" ) Then
		    PS.Bind( 3, Trim( Payload.Value( "URL" ) ), PS.SQLITE_TEXT )
		  Else
		    PS.Bind( 3, Nil, PS.SQLITE_NULL )
		  End If
		  
		  // Execute the statement.
		  PS.SQLExecute
		  
		  // Try to get the record...
		  SQL = "SELECT * FROM Drummers WHERE Drummer_Name = ?"
		  PS = Database.Prepare( SQL )
		  PS.Bind( 0, Trim( Payload.Value("DrummerName") ), PS.SQLITE_TEXT )
		  Records = PS.SQLSelect
		  If Records.RecordCount = 0 Then
		    Response.Status = 500
		    Response.Headers.Value( "X-Error" ) = "Record creation failed."
		    Return 
		  End If
		  
		  // Convert the recordset to a JSON object.
		  Dim Drummers As JSONItem = RecordSetToJSONItem( Records ) 
		  
		  // Set the response content to a decoded version of the JSON object.
		  Response.Content = Drummers.ToString
		  
		  // Update the status code to "201 Created."
		  Response.Status = 201
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetConsole and (Target64Bit)) or  (TargetWeb and (Target64Bit)) or  (TargetDesktop and (Target64Bit)) or  (TargetIOS and (Target64Bit)) )
		Sub DrummersProcess()
		  
		  // Process the request based on the HTTP method...
		  If Request.Method = "OPTIONS" Then
		    Response.Status = 204
		    Response.Headers.Value( "Allow" ) = "OPTIONS, DELETE, GET, POST, PUT"
		  ElseIf Request.Method = "DELETE" Then
		    DrummersDelete
		  ElseIf Request.Method = "GET" Then
		    DrummersGet
		  ElseIf Request.Method = "POST" Then
		    DrummersPost
		  ElseIf Request.Method = "PUT" Then
		    DrummersPut
		  Else
		    Response.Status = 405
		    Response.Headers.Value( "X-Error" ) = "Method Not Allowed"
		    Response.Headers.Value( "Allow" ) = "OPTIONS, DELETE, GET, POST, PUT"
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetConsole and (Target64Bit)) or  (TargetWeb and (Target64Bit)) or  (TargetDesktop and (Target64Bit)) or  (TargetIOS and (Target64Bit)) )
		Sub DrummersPut()
		  
		  
		  
		  
		  Dim Payload As JSONItem
		  Dim SQL As String
		  Dim PS As SQLitePreparedStatement
		  Dim Records As RecordSet
		  
		  // If no record ID was specified...
		  If Request.PathComponents.Count <> 3 Then
		    Response.Status = 400
		    Response.Headers.Value( "X-Error" ) = "Resource ID is missing."
		    Return 
		  End If
		  
		  // Get the ID of the record being requested.
		  Dim RecordID As String = Request.PathComponents(2)
		  
		  // If the record ID is not an integer...
		  If IsInteger( RecordID ) = False Then
		    Response.Status = 400
		    Response.Headers.Value( "X-Error" ) = "Resource ID must be an integer."
		    Return 
		  End If
		  
		  // Get the record.
		  SQL = "SELECT * FROM Drummers WHERE Drummer_ID = ?"
		  PS = Database.Prepare( SQL )
		  PS.Bind( 0, RecordID, PS.SQLITE_INTEGER )
		  Records = PS.SQLSelect
		  
		  // If no record was returned...
		  If Records.RecordCount = 0 Then
		    Response.Status = 404
		    Response.Headers.Value( "X-Error" ) = "Invalid RecordID specified."
		    Return 
		  End If
		  
		  // Try to convert the request body to JSON.
		  Try
		    Payload = New JSONItem( Request.Body )
		  Catch JSONException
		    Response.Status = 400
		    Response.Headers.Value( "X-Error" ) = "Unable to convert the payload to JSON."
		    Return
		  End Try
		  
		  // Validate the request.
		  If ( ( Payload.HasName( "DrummerName" ) = False ) or ( Trim( Payload.Value( "DrummerName" ) ) = "" ) ) Then
		    Response.Status = 400
		    Response.Headers.Value( "X-Error" ) = "Missing value for DrummerName."
		    Return
		  End If
		  If Payload.HasName( "Votes" ) Then
		    If IsInteger( Payload.Value( "Votes" ) ) = False Then
		      Response.Status = 400
		      Response.Headers.Value( "X-Error" ) = "Value for Votes must be an integer."
		      Return
		    End If
		  End If
		  
		  // Check for duplicates...
		  SQL = "SELECT * FROM Drummers WHERE Drummer_Name = ? And Drummer_ID <> ?"
		  PS = Database.Prepare( SQL )
		  PS.Bind( 0, Trim( Payload.Value( "DrummerName" ) ), PS.SQLITE_TEXT )
		  PS.Bind( 1, RecordID, PS.SQLITE_INTEGER )
		  Records = PS.SQLSelect
		  If Records.RecordCount > 0 Then
		    Response.Status = 400
		    Response.Headers.Value( "X-Error" ) = "A drummer with that name already exists."
		    Return 
		  End If
		  
		  // Create the statement and bind variables.
		  SQL = "UPDATE Drummers SET Drummer_Name = ?, Band_Name = ?, Votes = ?, URL = ? WHERE Drummer_ID = ?"
		  PS = Database.Prepare( SQL )
		  PS.Bind( 0, Trim( Payload.Value( "DrummerName" ) ), PS.SQLITE_TEXT )
		  If Payload.HasName( "BandName" ) Then
		    PS.Bind( 1, Trim( Payload.Value( "BandName" ) ), PS.SQLITE_TEXT )
		  Else
		    PS.Bind( 1, Nil, PS.SQLITE_NULL )
		  End If
		  If Payload.HasName( "Votes" ) Then
		    PS.Bind( 2, Trim( Payload.Value( "Votes" ) ), PS.SQLITE_INTEGER )
		  Else
		    PS.Bind( 2, Nil, PS.SQLITE_NULL )
		  End If
		  If Payload.HasName( "URL" ) Then
		    PS.Bind( 3, Trim( Payload.Value( "URL" ) ), PS.SQLITE_TEXT )
		  Else
		    PS.Bind( 3, Nil, PS.SQLITE_NULL )
		  End If
		  PS.Bind( 4, RecordID, PS.SQLITE_INTEGER )
		  
		  // Execute the statement.
		  PS.SQLExecute
		  
		  // Try to get the record...
		  SQL = "SELECT * FROM Drummers WHERE Drummer_Name = ?"
		  PS = Database.Prepare( SQL )
		  PS.Bind( 0, Trim( Payload.Value("DrummerName") ), PS.SQLITE_TEXT )
		  Records = PS.SQLSelect
		  If Records.RecordCount = 0 Then
		    Response.Status = 500
		    Response.Headers.Value( "X-Error" ) = "Record creation failed."
		    Return 
		  End If
		  
		  // Convert the recordset to a JSON object.
		  Dim Drummers As JSONItem = RecordSetToJSONItem( Records ) 
		  
		  // Set the response content to a decoded version of the JSON object.
		  Response.Content = Drummers.ToString
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetConsole and (Target64Bit)) or  (TargetWeb and (Target64Bit)) or  (TargetDesktop and (Target64Bit)) or  (TargetIOS and (Target64Bit)) )
		Function IsInteger(S As String) As Boolean
		  
		  // If the string does not represent a numeric value...
		  If IsNumeric( S ) = False Then
		    Return False
		  End If
		  
		  // If the string is a double...
		  If S <> S.Replace( ".", "" ) Then
		    Return False
		  End If
		  
		  Return True
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetConsole and (Target64Bit)) or  (TargetWeb and (Target64Bit)) or  (TargetDesktop and (Target64Bit)) or  (TargetIOS and (Target64Bit)) )
		Function RecordSetToJSONItem(Records As RecordSet, Close As Boolean=True) As JSONItem
		  // Converts a recordset to JSONItem.
		  
		  
		  Dim RecordsJSON As New JSONItem
		  
		  // Loop over each record...
		  While Not Records.EOF
		    
		    Dim RecordJSON As New JSONItem
		    
		    // Loop over each column...
		    For i As Integer = 0 To Records.FieldCount-1
		      
		      // Add a name / value pair to the JSON record.
		      RecordJSON.Value( Records.IdxField(i+1).Name ) = Records.IdxField(i+1).StringValue
		      
		    Next
		    
		    // Add the JSON record to the JSON records object.
		    RecordsJSON.Append(RecordJSON)
		    
		    // Go to the next row.
		    Records.MoveNext
		    
		  Wend
		  
		  // Close the recordset.
		  If Close Then
		    Records.Close
		  End If
		  
		  Return RecordsJSON
		  
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetConsole and (Target64Bit)) or  (TargetWeb and (Target64Bit)) or  (TargetDesktop and (Target64Bit)) or  (TargetIOS and (Target64Bit)) )
		Sub RequestAuthenticate()
		  
		  // If the Authorization header is missing...
		  If Request.Headers.HasKey( "Authorization" ) = False Then
		    Response.Status = 401
		    Response.Headers.Value( "X-Error" ) = "Missing Authorization header."
		    Return
		  End If
		  
		  // Get the header value.
		  Dim Authorization As String = Request.Headers.Value( "Authorization" )
		  
		  // Remove the "Basic" prefix.
		  Authorization = Authorization.Replace( "Basic ", "" )
		  
		  // Decode the authorization string.
		  Dim Credentials As String = DecodeBase64( Authorization, Encodings.UTF8 )
		  
		  // Split the credentials into the username / password values.
		  Dim Username As String = Credentials.NthField( ":", 1 )
		  Dim Password As String = Credentials.NthField( ":", 2 )
		  
		  // If the username or password are incorrect...
		  If ( ( Username <> "DemoUser" ) or ( StrComp( Password, "DemoPassword", 1 ) <> 0 ) ) Then
		    Response.Status = 401
		    Response.Headers.Value( "X-Error" ) = "Invalid credentials."
		    Return
		  End If
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetConsole and (Target64Bit)) or  (TargetWeb and (Target64Bit)) or  (TargetDesktop and (Target64Bit)) or  (TargetIOS and (Target64Bit)) )
		Sub RequestRoute()
		  
		  
		  // Route the request based on the resource (table) that was specified.
		  If Request.PathComponents(1) = "drummers" Then
		    DrummersProcess
		  Else
		    Response.Status = 404
		    Response.Headers.Value( "X-Error" ) = "Unknown resource."
		  End If
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetConsole and (Target64Bit)) or  (TargetWeb and (Target64Bit)) or  (TargetDesktop and (Target64Bit)) or  (TargetIOS and (Target64Bit)) )
		Database As SQLiteDatabase
	#tag EndProperty

	#tag Property, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetConsole and (Target64Bit)) or  (TargetWeb and (Target64Bit)) or  (TargetDesktop and (Target64Bit)) or  (TargetIOS and (Target64Bit)) )
		Request As AloeXWS.Request
	#tag EndProperty

	#tag Property, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetConsole and (Target64Bit)) or  (TargetWeb and (Target64Bit)) or  (TargetDesktop and (Target64Bit)) or  (TargetIOS and (Target64Bit)) )
		Response As AloeXWS.Response
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
