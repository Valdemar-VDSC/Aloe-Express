#tag Class
Protected Class App
Inherits AloeXWS.Application
	#tag Event
		Sub HandleRequest(Request As AloeXWS.Request, Response As AloeXWS.Response)
		  // Route the request.
		  
		  
		  // If this is a request for the root...
		  If Request.PathComponents.Count = 0 Then
		    Response.ContentType = "text/html"
		    Response.Content = "<div style=""text-align: center; font-size: 18pt;"">Aloe XWS " + AloeXWS.MajorVersion.ToString + "." + AloeXWS.MinorVersion.ToString + "</div>" _
		    + "<div style=""text-align: center; font-size: 14pt;"">Running on Xojo " + XojoVersionString + ".</div>"
		    Return
		  End If
		  
		  // If this is a request for the "echo" function...
		  If Request.Path = "echo" Then
		    Response.Content = Echo( Request )
		    Return
		  End If
		  
		  // If this is a request for the API demo...
		  If Request.PathComponents(0) = "apidemo" Then
		    Dim rh As New RESTAPIDemo.RequestHandler( Request, Response )
		    Return
		  End If
		  
		  // The request could not be processed.
		  Response.Headers.Value( "X-Error" ) = "Unable to route the request."
		  Response.Status = 404
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetConsole and (Target64Bit)) or  (TargetWeb and (Target64Bit)) or  (TargetDesktop and (Target64Bit)) or  (TargetIOS and (Target64Bit)) )
		Function Echo(Request As AloeXWS.Request) As String
		  // Returns a JSON string representation of the request.
		  
		  Dim J As New JSONItem
		  J.Value( "Body" ) = Request.Body
		  J.Value( "ContentLength" ) = Request.ContentLength
		  J.Value( "ContentType" ) = Request.ContentType
		  J.Value( "GET" ) = Request.GET
		  J.Value( "Headers" ) = Request.Headers
		  J.Value( "Method" ) = Request.Method
		  J.Value( "Path" ) = Request.Path
		  J.Value( "PathComponents" ) = Request.PathComponents
		  J.Value( "POST" ) = Request.POST
		  J.Value( "RemoteAddress" ) = Request.RemoteAddress
		  
		  Return J.ToString
		  
		End Function
	#tag EndMethod


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
