#tag Class
Protected Class Response
	#tag CompatibilityFlags = API2Only and ( (TargetWeb and (Target64Bit)) )
	#tag Method, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetConsole and (Target64Bit)) or  (TargetWeb and (Target64Bit)) or  (TargetDesktop and (Target64Bit)) or  (TargetIOS and (Target64Bit)) )
		Sub Constructor()
		  // Set default response headers.
		  Headers = New Dictionary
		  Headers.Value( "Connection" ) = "Close"
		  Headers.Value( "Date" ) = Str( DateToRFC1123 )
		  Headers.Value( "X-Powered-By" ) = "Xojo/" + Str( XojoVersion )
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetConsole and (Target64Bit)) or  (TargetWeb and (Target64Bit)) or  (TargetDesktop and (Target64Bit)) or  (TargetIOS and (Target64Bit)) )
		Function ToJSON() As JSONItem
		  // Returns a JSON representation of the response.
		  
		  Dim J As New JSONItem
		  J.Value( "Content" ) = Content
		  J.Value( "ContentType" ) = ContentType
		  If File <> Nil Then
		    J.Value( "File" ) = File.NativePath
		  Else
		    J.Value( "File" ) = ""
		  End If
		  J.Value( "Headers" ) = Headers
		  J.Value( "Status" ) = Status
		  
		  Return J
		  
		End Function
	#tag EndMethod


	#tag Property, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetConsole and (Target64Bit)) or  (TargetWeb and (Target64Bit)) or  (TargetDesktop and (Target64Bit)) or  (TargetIOS and (Target64Bit)) )
		Content As String
	#tag EndProperty

	#tag Property, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetConsole and (Target64Bit)) or  (TargetWeb and (Target64Bit)) or  (TargetDesktop and (Target64Bit)) or  (TargetIOS and (Target64Bit)) )
		ContentType As String = "application/json"
	#tag EndProperty

	#tag Property, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetConsole and (Target64Bit)) or  (TargetWeb and (Target64Bit)) or  (TargetDesktop and (Target64Bit)) or  (TargetIOS and (Target64Bit)) )
		File As FolderItem
	#tag EndProperty

	#tag Property, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetConsole and (Target64Bit)) or  (TargetWeb and (Target64Bit)) or  (TargetDesktop and (Target64Bit)) or  (TargetIOS and (Target64Bit)) )
		Headers As Dictionary
	#tag EndProperty

	#tag Property, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetConsole and (Target64Bit)) or  (TargetWeb and (Target64Bit)) or  (TargetDesktop and (Target64Bit)) or  (TargetIOS and (Target64Bit)) )
		Status As Integer = 200
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
		#tag ViewProperty
			Name="Content"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="Status"
			Visible=false
			Group="Behavior"
			InitialValue="200 OK"
			Type="Integer"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ContentType"
			Visible=false
			Group="Behavior"
			InitialValue="text/html"
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
