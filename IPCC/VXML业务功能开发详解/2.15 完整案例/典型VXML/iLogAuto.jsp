<?xml version = "1.0" encoding="gb2312"?>
<vxml version="2.0"> 
<%@ page contentType="text/html; charset=gb2312"%> 

 	<% 	
 		String rs = "";
 	%>
<form id="ReturnParam">
	<block> 
	 <var name="Result" expr="'<%=rs%>'" />	
	 <return namelist="Result" /> 
	</block>
</form>
</vxml>
