<?xml version = "1.0" encoding = "gb2312"?>
<%@ page contentType="text/html; charset=GBK"%>
<vxml version = "1.0">

<%
	String Flag_Temp = "";
%>
	
<form id="form_SendFaxDemo">
	         <script>        
      <![CDATA[
          function  getCurrentTime()
          {
         	    var sTime="";
         	    var CurDate = new  Date();
         	             	
         	    var sYear = CurDate.getFullYear();
              sTime = sYear;
              
              var sMonth = CurDate.getMonth() + 1;     
              sTime += ((sMonth<10) ? "0" :"")+sMonth;      
              
              var sDay = CurDate.getDate();
              sTime +=((sDay<10) ? "0" :"")+sDay;       
              
              var sHours = CurDate.getHours();
              sTime +=((sHours<10) ? "0" :"")+sHours;      
              
              var sMinutes = CurDate.getMinutes();
              sTime +=((sMinutes<10) ? "0" :"")+sMinutes;
              
              var sSeconds = CurDate.getSeconds();
              sTime +=((sSeconds<10) ? "0" :"")+sSeconds;    
               
              return sTime;
          }
      ]]>                     
    </script> 
	<var name="o_FileName" expr="Object()"/>
	<var name="o_CallerNo" expr="Object()"/>
	<var name="o_SendNo" expr="Object()"/>
	<var name="o_FileType" expr="Object()"/>
	<var name="o_FaxID" expr="Object()"/>
	<var name="o_FaxSource" expr="Object()"/>
	<var name="o_Flag"		expr="Object()"/>
	<var name="o_Ret" expr="Object()"/>
	<var name="o_Ret2" expr="Object()"/>
	<var name="i_FileName" expr="Object()"/>
	<var name="i_CallerNo" expr="Object()"/>
	<var name="i_SendNo" expr="Object()"/>
	<var name="i_FaxID" expr="Object()"/>
	<var name="i_Flag"		expr="Object()"/>
	<var name="FileName"/>
	<var name="FaxID"/>
	<var name="FaxStatus"/>
	<var name="CallerNo"/>
	<var name="SendTime"/>
	<var name="SendCount"/>
	<var name="FaxSource"/>
	<var name="SendNo"/>
	<var name="nCause" />
	<var name="oOutPageCount"/>
	<var name="nResultCode"/>
	<var name="callee_ssp"/>
	<var name="IsRetry"/>
	<block>
		<assign name="o_FileName.type" expr="'String'"/>
		<assign name="o_FileName.size" expr="60"/>
		<assign name="o_FileName.inout" expr="1"/>
		<assign name="o_CallerNo.type" expr="'String'"/>
		<assign name="o_CallerNo.size" expr="30"/>
		<assign name="o_CallerNo.inout" expr="1"/>
		<assign name="o_SendNo.type" expr="'String'"/>
		<assign name="o_SendNo.size" expr="'30'"/>
		<assign name="o_SendNo.inout" expr="1"/>		
		<assign name="o_FileType.type" expr="'INT_1'"/>
		<assign name="o_FileType.inout" expr="1"/>
		<assign name="o_FaxID.type" expr="'String'"/>
		<assign name="o_FaxID.size" expr="'60'"/>
		<assign name="o_FaxID.inout" expr="1"/>	
		<assign name="o_FaxSource.type" expr="'String'"/>
		<assign name="o_FaxSource.size" expr="1"/>
		<assign name="o_FaxSource.inout" expr="1"/>
		<assign name="o_Flag.type" expr="'INT_1'"/>
		<assign name="o_Flag.inout" expr="1"/>
		<assign name="o_Ret.type" expr="'INT_1'"/>
		<assign name="o_Ret.inout" expr="1"/>
		<assign name="o_Ret2.type" expr="'INT_1'"/>
		<assign name="o_Ret2.inout" expr="1"/>
		<assign name="i_FaxID.type" expr="'String'"/>
		<assign name="i_FaxID.size" expr="'60'"/>
		<assign name="i_FaxID.inout" expr="0"/>	
		<assign name="i_FileName.type" expr="'String'"/>
		<assign name="i_FileName.size" expr="60"/>
		<assign name="i_FileName.inout" expr="0"/>
		<assign name="i_CallerNo.type" expr="'String'"/>
		<assign name="i_CallerNo.size" expr="30"/>
		<assign name="i_CallerNo.inout" expr="0"/>
		<assign name="i_SendNo.type" expr="'String'"/>
		<assign name="i_SendNo.size" expr="'30'"/>
		<assign name="i_SendNo.inout" expr="0"/>		
		<assign name="i_Flag.type" expr="'INT_1'"/>
		<assign name="i_Flag.inout" expr="0"/>
	</block>
	

	
	<object name="dbtest" classid="method://huawei/Db/DbExecProc">
    	<param name="ProcName" expr="'P_SCE_GetFaxFile'"/>
    	<param name="DataSource" expr="'icdpt'"/>
    	<param name="o_CallerNo" expr="o_CallerNo"/>
    	<param name="o_SendNo" 		expr="o_SendNo"/>
    	<param name="o_FileName" expr="o_FileName"/>
    	<param name="o_FileType" expr="o_FileType"/>
    	<param name="o_FaxID" expr="o_FaxID"/>
    	<param name="o_FaxSource" expr="o_FaxSource"/>
    	<param name="o_Flag"		 expr="o_Flag"/>
    	<param name="o_Ret" expr="o_Ret"/>
		<filled>
			<assign name="FileName" expr="o_FileName.value"/>
			<assign name="FaxID" expr="o_FaxID.value"/>
			<assign name="FaxSource" expr="o_FaxSource.value"/>
			<assign name="SendCount" expr="o_Flag.value+1"/>
			<assign name="i_FaxID.value" expr="FaxID"/>
			<assign name="i_Flag.value" expr="SendCount"/>
			<if cond="o_CallerNo.value == ''">
				<exit/>
			</if>
			<if cond="dbtest =='SUCCESS'">
				<if cond="o_CallerNo.value == ''">
					<exit/>
				<elseif cond="o_FileType.value == 0"/>
					<goto nextitem="myUseDll"/>
				</if>
				<goto nextitem="CallOtherPlatform"/>
			<else/>
				<exit/>
			</if>
			
		</filled>
	</object>

	<object name="myUseDll" classid="method://huawei/Extend/UseDll">
		<param name="LibName" value="icd1861.dll"/>
		<param name="FunctionName" value="FlowTxtToTif"/>
		<param name="Param1" expr="o_FileName.value" type="string:in"/>
		<param name="Param2" expr="FileName" type="string:out"/>
		<param name="Param2" expr="oOutPageCount" type="char:out"/>
		<param name="ResultCode" expr="nResultCode"/>
		<filled>
			<if cond="nResultCode == '0'">
					<goto nextitem="sleep"/>
			<else/>
					<exit/>
			</if>
		</filled>
	</object>
	
		<object name="sleep" classid="method://huawei/Other/Sleep">
				<param name="TimeOut" value="10"/>
				<filled>
						<if cond="sleep != 'USER_HOOK'">
								<goto nextitem="CallOtherPlatform"/>
						</if>
						<goto nextitem="updateflag"/>
				</filled>
		</object>
	
    <object name="CallOtherPlatform" classid="method://huawei/Call/CallOut">
        <param name="TimeOut"        expr="60"/>
        <param name="CLI"            expr="'10000'"/>
        <param name="CLD"            expr="o_SendNo.value"/>  
        <param name="SSP"            expr="callee_ssp"/>    
       
        <filled>
        		<assign name="SendTime" expr="getCurrentTime()"/>                                                
            <if cond="CallOtherPlatform == 'HOOK_OFF'">
              <goto nextitem="Invoke_SendFax"/>                  
            <elseif cond="CallOtherPlatform == 'USER_HOOK'"/> 
            		<assign name="FaxStatus" expr="'Failure'"/>
								<if cond=" SendCount == <%=Flag_Temp%>">
									<assign name="i_Flag.value" expr="3"/>
									<assign name="IsRetry" expr="'N'"/>
								<else/>
									<assign name="IsRetry" expr="'Y'"/>	
								</if>
                <goto nextitem="updateflag"/>
            <else/>
            		<assign name="FaxStatus" expr="'Failure'"/>
								<if cond=" SendCount == <%=Flag_Temp%>">
									<assign name="i_Flag.value" expr="3"/>
									<assign name="IsRetry" expr="'N'"/>
								<else/>
									<assign name="IsRetry" expr="'Y'"/>	
								</if>
     						<goto nextitem="updateflag"/>
            </if>
        </filled>
    </object> 

    <subdialog name="Invoke_SendFax"    src="Func_Fax.jsp#form_SendFax" >
        <param name="i_SndFaxFileName"  expr="FileName"/>
        <filled>
						<assign name="SendTime" expr="getCurrentTime()"/>
        		<if cond="Invoke_SendFax.ret_result == '0'">
								<assign name="FaxStatus" expr="'Success'"/>
								<assign name="IsRetry" expr="'N'"/>
						<else/>
								<assign name="FaxStatus" expr="'Failure'"/>
								<if cond=" SendCount == <%=Flag_Temp%>">
									<assign name="i_Flag.value" expr="3"/>
									<assign name="IsRetry" expr="'N'"/>
								<else/>
									<assign name="IsRetry" expr="'Y'"/>	
								</if>
						</if>
						<goto nextitem="updateflag" />
        </filled>
    </subdialog>
    		
    <object name="updateflag" classid="method://huawei/Db/DbExecProc">
				<param name="ProcName" expr="'P_SCE_UPDATEFAXFLAG'"/>
				<param name="DataSource" expr="'icdpt'"/>
				<param name="i_FaxID" expr="i_FaxID"/>
				<param name="i_Flag" expr="i_Flag"/>
				<param name="o_Ret"	 expr="o_Ret2"/>
				<filled>
						<if cond="FaxID == ''">
						
						<else/>
								<submit next="Seibel_Com.jsp" namelist="FaxID FaxStatus SendTime SendCount FaxSource IsRetry"/>	
						</if>
				</filled>
		</object>
</form>
</vxml>