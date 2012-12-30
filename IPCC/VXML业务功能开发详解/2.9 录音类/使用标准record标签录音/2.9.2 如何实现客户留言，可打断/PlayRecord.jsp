<%@ page language="java" import="com.huawei.fileUpload.*"%>
<%@ page contentType="text/html;charset=gb2312"%>
<%
	String 	sWavName = request.getParameter("FileName");
	if( sWavName != null )
	{
		String	sURL = "http://10.166.102.154:8080/VXML/upload/wikiwiki/";
		sWavName = sURL + sWavName;
	}
	else
	{
		out.println("The WAV filename is null!");
	}
%>
<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
	<form>
	<property name="inputmodes" value="dtmf"/>
		<block>
			<audio src="<%=sWavName%>"></audio>
		</block>
	</form>
</vxml>