<%@ page language="java" import="com.huawei.fileUpload.*"%>
<%@ page contentType="text/html;charset=gb2312"%>
<%@ page import="java.io.File"%>
<%@ page import="java.util.Date"%>

<%
	com.huawei.fileUpload.upBean faxUpload = new com.huawei.fileUpload.upBean();
	// upBean faxUpload = new upBean();
	faxUpload.initialize(pageContext);
	faxUpload.setAllowedExtList("tif,txt,wav");
	faxUpload.setIsCover(true);
	String[] sourceName = null;
	String myName=new String("");	
	String	sFPShareDir = "F:\\work\\VXML\\upload\\wikiwiki";
	faxUpload.setRealPath(sFPShareDir);

	try
	{
		//将所有数据导入组件的数据结构中
		faxUpload.upload();
	}
	catch(Exception e)
	{
		throw e;
	}
	
	// 获取页面上的多个参数

	try
	{
		//得到所有上传的文件
		files myFiles = faxUpload.getFiles();

		if( myFiles != null )
		{
			int	iFileCount = myFiles.getCount();
			System.out.println(iFileCount);
			sourceName = new String[iFileCount];
			Date	CurrentDate = new Date();
			Long	lCurrentTime = new Long( CurrentDate.getTime() );
			//将文件保存到服务器
			for(int i = 0; i < iFileCount; i++)
			{
				
				myName = lCurrentTime.toString();
				myName = myName + "_" + i+ "."+myFiles.getFile(i).getExtName();
				sourceName[i]=myFiles.getFile(i).getName();
				myFiles.getFile(i).setName(myName);
				//有两种保存方法，一种是保存在faxUpload.setRealPath()的设定路径中，使用saveAs()，一种是另外保存到其他文件夹,使用.saveAs(String realPath)
				myFiles.getFile(i).saveAs();
			}
		} 
	}
	catch (	Exception e) 
	{
		throw e;
	}
	if( myName != null && !myName.equals("") )
	{
		System.out.println(myName);
%>
<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
	<form>
		<var name="FileName"/>
		<block>
			<assign name="FileName" expr="'<%=myName%>'"/>
			<submit next="playrecord.jsp" namelist="FileName"/>
		</block>
	</form>
</vxml>
<%
}
%>