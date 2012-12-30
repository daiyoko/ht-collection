<?xml version = "1.0" encoding="gb2312"?>
<vxml version="1.0"> 
<%@ page contentType="text/html; charset=gb2312"%> 
<%@page	import="java.sql.*"%> 

 <%
 	
 	//CallableStatement proc = null;
 	//Connection conn = null; 	
    String erroMsg="";  
    //Log log=LogFactory.getLog("ivr:operateData");
 		
 		String calledNumber = request.getParameter("inCalledNumber");
 		String callingNumber=request.getParameter("inCallingNumber");
 		String toAgentMsg=request.getParameter("toAgentMsg"); 		
 		int operDataType = Integer.parseInt(request.getParameter("operDataType"));
 		String inStrRes1=request.getParameter("dataInStrRes1");  
 		String inStrRes2=request.getParameter("dataInStrRes2");
 		String outOperateData="";
 		int outResult=-1;
 		String outStrRes1="";
 		String outStrRes2="";
 		String sql = "{call pro_auto_OperData(?,?,?,?,?,?,?,?,?,?,?)}";
 		//BeanProcHandler procBean = new BeanProcHandler();
 		//try {
 		//	conn = procBean.getCon();
 		//	proc = conn.prepareCall(sql);
 		
 		//	proc.setString(1, callingNumber);
 		//	proc.setString(2, calledNumber);
 		//	proc.setString(3, toAgentMsg);
 		//	proc.setInt(4,1); 		
 		//	proc.setInt(5, operDataType);
 		//	proc.registerOutParameter(6, Types.VARCHAR);
 		//	proc.registerOutParameter(7, Types.INTEGER);
 		//	proc.setString(8, inStrRes1);
 		//	proc.setString(9, inStrRes2);
 		//	proc.registerOutParameter(10, Types.VARCHAR);
 		//	proc.registerOutParameter(11, Types.VARCHAR); 			
 		//	proc.execute();
 		//	outOperateData = proc.getString(6);
 		//	outResult = proc.getInt(7);
 		//	outStrRes1 = proc.getString(10);
 		//	outStrRes2 = proc.getString(11); 			
 		//} catch (Exception ex) {
 			//ex.printStackTrace();
 			//erroMsg = "operateData--callingNumber:" + callingNumber+";calledNumber:"+calledNumber+";operDataType:"+operDataType+";operData:"+outOperateData;
 		    //log.error(erroMsg); 		}
 		//finally { 			
 			//if (proc != null) {
 	       // 	try {
 			//           proc.close();
 	      //        	} catch (Exception ex) {
 			//         ex.printStackTrace();    }
 			//    }

 			//if (conn != null) {
 		      //  try {
 			  //       procBean.release();
 	            //	} catch (Exception ex) {
 	          //      	conn.close();
 			      //      ex.printStackTrace(); 			           
 		      //        }
 		      ///   	} 	       	} 	       	
 	      // 	String  infoMsg = "operDataType:"+operDataType+";callingNumber:"+callingNumber+";inStrRes2:"+inStrRes2+"---result:"+outResult+"---outOperateData:"+outOperateData;
 		   //log.info(infoMsg); 
 		outResult = 1;
 		outOperateData= "0^1^1^0^0^106^1^1^1^1^1^1^1^1^1^1^1^1^1^1^1^1^1^1^1^1^1^1^1^1^1^1^1";
 		outStrRes1 = "1^1^1^1^1^1^1^1^8^1";
 		outStrRes2 = "1^1^1^1^1^1^1^1^1^1";
	%>
<form id="ReturnParam">
	<block>
	  
	  <var name="agentData" expr="'<%=outOperateData%>'"/>	
	  <var name="retResult" expr="'<%=outResult%>'"/>	
	  <var name="dataOutStrRes1" expr="'<%=outStrRes1%>'"/>	
	  <var name="dataOutStrRes2" expr="'<%=outStrRes2%>'"/>	
	 <return namelist="agentData retResult dataOutStrRes1 dataOutStrRes2" /> 
	</block>
</form>
</vxml>
