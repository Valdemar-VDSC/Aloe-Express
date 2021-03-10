#tag Class
Protected Class Application
Inherits WebApplication
	#tag CompatibilityFlags = API2Only and ( ( TargetWeb and ( Target64Bit ) ) )
	#tag Event
		Function HandleURL(Request As WebRequest, Response As WebResponse) As Boolean
		  // Create a Web Service Request instance based on the original WebRequest.
		  Dim XWSRequest As New AloeXWS.Request( Request )
		  
		  // Create a Web Service Response instance.
		  Dim XWSResponse As New AloeXWS.Response
		  
		  // Process the request.
		  HandleRequest( XWSRequest, XWSResponse )
		  
		  // Specify the HTTP response status.
		  Response.Status = XWSResponse.Status
		  
		  // Loop over the response header dictionary entries...
		  XWSResponse.Headers.Value( "Content-Type" ) = XWSResponse.ContentType
		  For Each Key As Variant in XWSResponse.Headers.Keys
		    
		    // Add the header.
		    Response.Header( Key ) = XWSResponse.Headers.Value( Key )
		    
		  Next
		  
		  // If we're not returning back a file...
		  If XWSResponse.File = Nil Then
		    
		    // Return the content.
		    Response.Write ( XWSResponse.Content )
		    
		  Else
		    
		    // Return the file.
		    Request.File = XWSResponse.File
		    
		  End If
		  
		  // Return True so that the WebApplication doesn't try to process the request.
		  Return True
		End Function
	#tag EndEvent


	#tag Hook, Flags = &h0
		Event HandleRequest(Request As AloeXWS.Request, Response As AloeXWS.Response)
	#tag EndHook


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
