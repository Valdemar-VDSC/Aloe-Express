#tag Class
Protected Class Sessions
	#tag CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target32Bit or Target64Bit))
	#tag Method, Flags = &h0
		Sub BodyContentGenerate()
		  
		  
		  
		  // Generate the sessions table.
		  TableGenerate
		  
		  // Add the content to the page.
		  BodyContent = PageContent + TableHTML
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub Constructor(Request As AloeExpress.Request)
		  // Store the request instance so that it can be used throughout the class.
		  Self.Request = Request
		  
		  
		  // Get a session.
		  Request.SessionGet
		  
		  
		  // If the user has not been authenticated...
		  If Request.Session.Lookup("Authenticated", False) = False Then
		    Request.Response.MetaRefresh("/login")
		    Return
		  End If
		  
		  
		  // Generate the body content.
		  BodyContentGenerate
		  
		  
		  // Display the page.
		  PageDisplay
		  
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub PageDisplay()
		  // Load the template.
		  TemplateLoad
		  
		  
		  // Substitute special tokens.
		  HTML = HTML.ReplaceAll("[[H1]]", "Sessions")
		  HTML = HTML.ReplaceAll("[[Content]]", BodyContent)
		  
		  
		  // Update the response content.
		  Request.Response.Content = HTML
		  
		  
		  // Update the request status code.
		  Request.Response.Status = "200"
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = (TargetConsole and (Target32Bit or Target64Bit)) or  (TargetWeb and (Target32Bit or Target64Bit)) or  (TargetDesktop and (Target32Bit or Target64Bit)) or  (TargetIOS and (Target32Bit or Target64Bit))
		Sub TableGenerate()
		  // Generates an HTML table to display the sessions that SessionEngineAE is managing.
		  
		  
		  // Open a table.
		  TableHTML = "" _
		  + "<table class=""gridtable"" width=""100%"">" _
		  + "<tr>" _
		  + "<th width=""30%"">Session ID</th>" _
		  + "<th width=""20%"">User IP Address</th>" _
		  + "<th width=""30%"">Username</th>" _
		  + "<th width=""10%"">Authenticated</th>" _
		  + "<th width=""10%""># Requests</th>" _
		  + "</tr>" + EndOfLine
		  
		  
		  // Loop over the server's session keys...
		  For Each Key As String in Request.Server.SessionEngine.SessionAllSessionIds
		    
		    // Get the entry's key and value.
		    Dim SessionID As String = Key
		    Dim Session As AloeExpress.Session = Request.Server.SessionEngine.SessionLookup(Key)
		    
		    // The session might have expired in the time it took to look it up
		    If Session Is Nil Then
		      Continue For Key
		    End If
		    
		    Dim RemoteAddress As String = Session.RemoteAddress
		    Dim Username As String = Session.Lookup("Username", "n/a")
		    Dim Authenticated As String = If (Session.Authenticated, "Yes", "No")
		    Dim RequestCount As Integer = Session.RequestCount
		    
		    TableHTML = TableHTML _
		    + "<tr>" + EndOfLine _
		    + "<td>" + SessionID + "</td>" + EndOfLine _
		    + "<td>" + RemoteAddress + "</td>" + EndOfLine _
		    + "<td>" + Username + "</td>" + EndOfLine _
		    + "<td>" + Authenticated + "</td>" + EndOfLine _
		    + "<td>" + RequestCount.ToText + "</td>" + EndOfLine _
		    + "<tr>" + EndOfLine
		    
		  Next
		  
		  
		  // Close the table.
		  TableHTML = TableHTML + "</table>" + EndOfLine
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub TemplateLoad()
		  // Loads the template file.
		  
		  // Create a folderitem that points to the template file.
		  Dim FI as FolderItem = Request.StaticPath.Child("template.html")
		  
		  // Use Aloe's FileRead method to load the file.
		  HTML = AloeExpress.FileRead(FI)
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0
		BodyContent As String
	#tag EndProperty

	#tag Property, Flags = &h0
		HTML As String
	#tag EndProperty

	#tag Property, Flags = &h0
		Request As AloeExpress.Request
	#tag EndProperty

	#tag Property, Flags = &h0
		Session As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0
		TableHTML As String
	#tag EndProperty


	#tag Constant, Name = PageContent, Type = String, Dynamic = False, Default = \"<p>\nThis is a protected page. You can only see it because you are logged in.\n</p>", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			Type="String"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
		#tag EndViewProperty
		#tag ViewProperty
			Name="HTML"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="BodyContent"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TableHTML"
			Group="Behavior"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
