#tag Module
Protected Module AloeXWS
	#tag CompatibilityFlags = API2Only and ( (TargetConsole and (Target64Bit)) or  (TargetWeb and (Target64Bit)) or  (TargetDesktop and (Target64Bit)) )
	#tag Method, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetConsole and (Target64Bit)) or  (TargetWeb and (Target64Bit)) or  (TargetDesktop and (Target64Bit)) or  (TargetIOS and (Target64Bit)) )
		Function DateToRFC1123(TheDate As DateTime = Nil) As Text
		  // Returns a  in RFC 822 / 1123 format.
		  // Example: Mon, 27 Nov 2017 13:27:26 GMT
		  // Special thanks to Norman Palardy.
		  // See: https://forum.xojo.com/42908-current-date-time-stamp-in-rfc-822-1123-format
		  
		  Dim tmp As Text
		  
		  If TheDate = Nil Then
		    Dim GMTTZ As New TimeZone( 0 )
		    TheDate = New DateTime( DateTime.Now.SecondsFrom1970, GMTTZ )
		  End If
		  
		  Select Case TheDate.DayOfWeek
		  Case 1
		    tmp = tmp + "Sun"
		  Case 2
		    tmp = tmp + "Mon"
		  Case 3
		    tmp = tmp + "Tue"
		  Case 4
		    tmp = tmp + "Wed"
		  Case 5
		    tmp = tmp + "Thu"
		  Case 6
		    tmp = tmp + "Fri"
		  Case 7
		    tmp = tmp + "Sat"
		  End Select
		  
		  tmp = tmp + ", "
		  
		  tmp = tmp + If(TheDate.Day < 10, "0", "" ) + TheDate.Day.ToText
		  
		  tmp = tmp + " "
		  
		  Select Case TheDate.Month
		  Case 1
		    tmp = tmp + "Jan" 
		  Case 2
		    tmp = tmp + "Feb" 
		  Case 3
		    tmp = tmp + "Mar"
		  Case 4
		    tmp = tmp + "Apr"
		  Case 5
		    tmp = tmp + "May" 
		  Case 6
		    tmp = tmp + "Jun" 
		  Case 7
		    tmp = tmp + "Jul" 
		  Case 8
		    tmp = tmp + "Aug"
		  Case 9
		    tmp = tmp + "Sep" 
		  Case 10
		    tmp = tmp + "Oct"
		  Case 11
		    tmp = tmp + "Nov" 
		  Case 12
		    tmp = tmp + "Dec"
		  End Select
		  
		  tmp = tmp + " "
		  
		  tmp = tmp + TheDate.Year.ToText
		  tmp = tmp + " "
		  
		  tmp = tmp + If(TheDate.Hour < 10, "0", "" ) + TheDate.Hour.ToText
		  tmp = tmp + ":"
		  
		  tmp = tmp + If(TheDate.Minute < 10, "0", "" ) + TheDate.Minute.ToText
		  tmp = tmp + ":"
		  
		  tmp = tmp + If(TheDate.Second < 10, "0", "" ) + TheDate.Second.ToText
		  tmp = tmp + " "
		  
		  tmp = tmp + "GMT"
		  
		  Return tmp
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetConsole and (Target64Bit)) or  (TargetWeb and (Target64Bit)) or  (TargetDesktop and (Target64Bit)) or  (TargetIOS and (Target64Bit)) )
		Function URLDecode(Encoded As String) As String
		  // Properly and fully decodes a URL-encoded value.
		  // Unlike Xojo's "DecodeURLComponent" function, this method decodes any "+" characters that represent encoded spaces.
		  
		  // Replace any "+" chars with spaces.
		  Encoded = Encoded.ReplaceAll( "+", " " )
		  
		  // Decode everything else.
		  Encoded = DecodeURLComponent( Encoded )
		  
		  Return Encoded
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0, CompatibilityFlags = API2Only and ( (TargetConsole and (Target64Bit)) or  (TargetWeb and (Target64Bit)) or  (TargetDesktop and (Target64Bit)) or  (TargetIOS and (Target64Bit)) )
		Function URLEncode(Value As String) As String
		  // A wrapper method for Xojo's EncodeURLComponent function, provided for consistency and convenience.
		  
		  Return EncodeURLComponent( Value )
		End Function
	#tag EndMethod


	#tag Note, Name = 2019.1
		Initial public production release.
		
	#tag EndNote

	#tag Note, Name = 2019.2
		Resolves and eliminates deprecation warnings that were introduced in Xojo 2019 R2.
		
	#tag EndNote

	#tag Note, Name = 2020.3
		Using API2 with Xojo 2020r2.1
		
	#tag EndNote

	#tag Note, Name = About
		-----------------------------------------------------------------------------------------
		About
		-----------------------------------------------------------------------------------------
		
		Aloe XWS is a Xojo Web service module that makes it easy for developers to create 
		Web services / APIs, microservices, middleware, and more.
		
		Aloe XWS:
		• Leverages the Xojo Web framework.
		• Provides an Application class that subclasses the Xojo WebApplication class.
		• Replaces the HandleURL event handler with a new HandleRequest event handler.
		• Provides simple, intuitive classes that represent HTTP requests and responses.
		
		
		-----------------------------------------------------------------------------------------
		Features
		-----------------------------------------------------------------------------------------
		
		Aloe XWS provides easy access to important attributes of an HTTP request, including:
		• Body
		• Content Type
		• GET (URL) parameters
		• Headers
		• Method (GET, POST, etc)
		• Path
		• POST fields
		• Remote Address
		
		Aloe XWS makes it easy to specify an HTTP response, including its:
		• Content
		• Content Type
		• Headers
		• Status
		
		
		-----------------------------------------------------------------------------------------
		Resources
		-----------------------------------------------------------------------------------------
		
		For more information, visit: 
		https://aloe.zone
		
		
	#tag EndNote

	#tag Note, Name = Developer
		-----------------------------------------------------------------------------------------
		Developer
		-----------------------------------------------------------------------------------------
		
		Tim Dietrich
		• Email: timdietrich@me.com
		• Web: http://timdietrich.me
		
		Modifications 2020.3 By Valdemar De SOUSA
	#tag EndNote

	#tag Note, Name = License
		-----------------------------------------------------------------------------------------
		The MIT License (MIT)
		-----------------------------------------------------------------------------------------
		
		Copyright (c) 2019 Timothy Dietrich
		
		Permission is hereby granted, free of charge, to any person obtaining a copy of this 
		software and associated documentation files (the "Software"), to deal in the Software 
		without restriction, including without limitation the rights to use, copy, modify, merge, 
		publish, distribute, sublicense, and/or sell copies of the Software, and to permit 
		persons to whom the Software is furnished to do so, subject to the following conditions:
		
		The above copyright notice and this permission notice shall be included in all copies 
		or substantial portions of the Software.
		
		THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, 
		EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF 
		MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. 
		IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY 
		CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, 
		TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE 
		SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
		
		To learn more, visit https://www.tldrlegal.com/l/mit.
	#tag EndNote


	#tag Constant, Name = MajorVersion, Type = Double, Dynamic = False, Default = \"2020", Scope = Public, CompatibilityFlags = API2Only and ( (TargetConsole and (Target64Bit)) or  (TargetWeb and (Target64Bit)) or  (TargetDesktop and (Target64Bit)) or  (TargetIOS and (Target64Bit)) )
	#tag EndConstant

	#tag Constant, Name = MinorVersion, Type = Double, Dynamic = False, Default = \"3", Scope = Public, CompatibilityFlags = API2Only and ( (TargetConsole and (Target64Bit)) or  (TargetWeb and (Target64Bit)) or  (TargetDesktop and (Target64Bit)) or  (TargetIOS and (Target64Bit)) )
	#tag EndConstant


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
End Module
#tag EndModule
