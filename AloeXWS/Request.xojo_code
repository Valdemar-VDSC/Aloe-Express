#tag Class
Protected Class Request
	#tag CompatibilityFlags = API2Only and ( ( TargetConsole and ( Target64Bit ) ) or ( TargetWeb and ( Target64Bit ) ) or ( TargetDesktop and ( Target64Bit ) ) or ( TargetIOS and ( Target64Bit ) ) )
	#tag Method, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetConsole and (Target64Bit)) or  (TargetWeb and (Target64Bit)) or  (TargetDesktop and (Target64Bit)) or  (TargetIOS and (Target64Bit)) )
		Sub Constructor(Request As WebRequest)
		  // Get the method.
		  Method = Request.Method.DefineEncoding(Encodings.UTF8)
		  
		  // Get the client address.
		  RemoteAddress = Request.RemoteAddress
		  
		  // Get the request path.
		  Path = Request.Path.DefineEncoding(Encodings.UTF8)
		  
		  // Strip the trailing slash from the path.
		  If Path.Right( 1 ) = "/" Then
		    Path = Path.Left( Path.Length - 1 )
		  End If
		  
		  // Get the content type.
		  ContentType = Request.Header( "Content-Type" )
		  
		  // Get the content-length.
		  ContentLength = Request.Header( "Content-Length" ).Val
		  
		  // Get the requets body.
		  Body = Request.Body
		  
		  // Create the path components by splitting the Path.
		  var AllPaths() As String
		  AllPaths = Request.Path.Split( "/" )
		  for Each mPath As String in AllPaths 
		    PathComponents.Append mPath.DefineEncoding(Encodings.UTF8)
		  next
		  
		  
		  // Create the GET dictionary.
		  GET = New Dictionary
		  
		  // Split the Params string into an array of strings.
		  // Example: a=123&b=456&c=999
		  Dim GETParams() As String = Request.QueryString.Split( "&" )
		  
		  // Loop over the URL params to create the GET dictionary.
		  For i As Integer = 0 To GETParams.LastRowIndex
		    Dim ThisParam As String = GETParams( i ).DefineEncoding(Encodings.UTF8)
		    Dim Key As String = ThisParam.NthField( "=", 1 ) .DefineEncoding(Encodings.UTF8)
		    Dim Value As String = ThisParam.NthField( "=", 2 ).DefineEncoding(Encodings.UTF8)
		    GET.Value(Key) = URLDecode( Value )
		  Next
		  
		  // Create the POST dictionary.
		  POST = New Dictionary
		  If ContentType = "application/x-www-form-urlencoded" Then
		    
		    // Split the Params string into an array of strings.
		    // Example: a=123&b=456&c=999
		    Dim POSTParams() As String = Request.Body.Split( "&" )
		    
		    // Loop over the URL params to create the POST dictionary.
		    For i As Integer = 0 To POSTParams.LastRowIndex
		      Dim ThisParam As String = POSTParams( i ).DefineEncoding(Encodings.UTF8)
		      Dim Key As String = ThisParam.NthField( "=", 1 ).DefineEncoding(Encodings.UTF8)
		      Dim Value As String = ThisParam.NthField( "=", 2 ).DefineEncoding(Encodings.UTF8)
		      POST.Value( Key ) = URLDecode( Value )
		    Next
		    
		  End If
		  
		  // Get the headers.
		  Headers = New Dictionary
		  For Each HeaderName As String In Request.HeaderNames
		    If HeaderName <> "" Then
		      Headers.Value( HeaderName ) = Request.Header( HeaderName ).DefineEncoding(Encodings.UTF8)
		    End If
		  Next
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetConsole and (Target64Bit)) or  (TargetWeb and (Target64Bit)) or  (TargetDesktop and (Target64Bit)) or  (TargetIOS and (Target64Bit)) )
		Body As String
	#tag EndProperty

	#tag Property, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetConsole and (Target64Bit)) or  (TargetWeb and (Target64Bit)) or  (TargetDesktop and (Target64Bit)) or  (TargetIOS and (Target64Bit)) )
		ContentLength As Integer = 0
	#tag EndProperty

	#tag Property, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetConsole and (Target64Bit)) or  (TargetWeb and (Target64Bit)) or  (TargetDesktop and (Target64Bit)) or  (TargetIOS and (Target64Bit)) )
		ContentType As String
	#tag EndProperty

	#tag Property, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetConsole and (Target64Bit)) or  (TargetWeb and (Target64Bit)) or  (TargetDesktop and (Target64Bit)) or  (TargetIOS and (Target64Bit)) )
		GET As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetConsole and (Target64Bit)) or  (TargetWeb and (Target64Bit)) or  (TargetDesktop and (Target64Bit)) or  (TargetIOS and (Target64Bit)) )
		Headers As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetConsole and (Target64Bit)) or  (TargetWeb and (Target64Bit)) or  (TargetDesktop and (Target64Bit)) or  (TargetIOS and (Target64Bit)) )
		Method As String
	#tag EndProperty

	#tag Property, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetConsole and (Target64Bit)) or  (TargetWeb and (Target64Bit)) or  (TargetDesktop and (Target64Bit)) or  (TargetIOS and (Target64Bit)) )
		Path As String
	#tag EndProperty

	#tag Property, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetConsole and (Target64Bit)) or  (TargetWeb and (Target64Bit)) or  (TargetDesktop and (Target64Bit)) or  (TargetIOS and (Target64Bit)) )
		PathComponents() As String
	#tag EndProperty

	#tag Property, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetConsole and (Target64Bit)) or  (TargetWeb and (Target64Bit)) or  (TargetDesktop and (Target64Bit)) or  (TargetIOS and (Target64Bit)) )
		POST As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetConsole and (Target64Bit)) or  (TargetWeb and (Target64Bit)) or  (TargetDesktop and (Target64Bit)) or  (TargetIOS and (Target64Bit)) )
		RemoteAddress As String
	#tag EndProperty


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
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
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
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
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="ContentType"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ContentLength"
			Visible=false
			Group="Behavior"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Method"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Body"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Path"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="RemoteAddress"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
