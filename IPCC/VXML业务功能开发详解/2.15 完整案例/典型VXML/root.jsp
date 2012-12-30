<?xml version="1.0" encoding="GB2312"?>
<vxml version="2.0">
	<property name="inputmodes" value="dtmf"/>
	<!-- Area -->
	<var name="accessArea" expr="''"/>
	<!-- Number -->
	<var name="inCallingNumber" expr="''"/>
	<var name="inCalledNumber" expr="''"/>
	<var name="accessCode" expr="''"/>
	<var name="inOriCalledNumber" expr="''"/>
	<var name="callingNumber" expr="''"/>
	<var name="calledNumber" expr="''"/>
	<var name="oriCalledNumber" expr="''"/>
	<var name="outCallingNumber" expr="''"/>
	<var name="outCalledNumber" expr="''"/>
	<var name="logSubAutoFlag" expr="'0'"/>
	<!--config paras-->
	<var name="AudioPath" expr="'Y:\\voice\\'"/>
	<var name="GroupCardPath" expr="'Y:\\\\jthb\\\\fstibst\\\\he\\\\GroupCard\\\\'"/>
	<var name="GroupADPath" expr="'Y:\\\\jthb\\\\fstibst\\\\he\\\\GroupAD\\\\'"/>
	<var name="TitleTonePath" expr="'Y:\\jthb\\fstibst\\he\\TitleTone\\'"/>
	<var name="digitWavPath" expr="'Y:\\jthb\\fstibst\\he\\digitWav\\'"/>
	<var name="LocalArea" expr="'311'"/>
	<var name="callFlowNO" expr="''"/>
	<!--0:OTA卡无需要放引导音， 1：需要放OTA分键音, 2,需要放引导音 -->
	<var name="OTAPromp" expr="'0'"/>
	<!--0:其他平台助理呼叫不放引导音， 1：需要放OTA分键音, 2,需要放引导音 -->
	<var name="assitantPlatPromp" expr="'0'"/>
	<!--0:特殊号码呼叫不放引导音， 1：需要放OTA分键音, 2,需要放引导音 -->
	<var name="otherPromp" expr="'2'"/>
	<!--0:VIP用户无需要放引导音， 1：需要放音 -->
	<var name="VIPPromp" expr="'1'"/>
	<var name="localMobileTran" expr="'0'"/>
	<!-- 手机转接标识(localMobileTran:本地；crossMobileTran异地)
	             0：直接为手机
	             1：手机前+0
	             2：手机前+区号	       -->
	<var name="crossMobileTran" expr="'1'"/>
	<var name="dfSkill" expr="''"/>
	<!-- 分键输入错误3次处理方式：1,转坐席；0,话务释放  -->
	<var name="menuHandle" expr="'1'"/>
	<var name="prompCount" expr="2"/>
	<var name="adToneID" expr="'0'"/>
	<var name="adToneKey" expr="''"/>
	<!-- 特殊引导音 -->
	<var name="speWelTone" expr="'2'"/>
	<!-- 随路数据 -->
	<var name="redPhoneFlag" expr="'0'"/>
	<var name="arrAgentData" expr="''"/>
	<var name="feeAreaNO" expr="''"/>
	<var name="logCallBeginTime" expr="''"/>
	<var name="logTranResult" expr="1"/>
	<var name="feeNO" expr="''"/>
	<var name="VIPFlag" expr="'00'"/>
	<var name="sqlType" expr="''"/>
	<var name="dataValid" expr="''"/>
	<var name="firstType" expr="'0'"/>
	<var name="secondType" expr="'0'"/>
	<var name="calledNum" expr="''"/>
	<var name="calledNO1" expr="''"/>
	<var name="calledNO2" expr="''"/>
	<var name="calledNO3" expr="''"/>
	<var name="feeAreaCode1" expr="''"/>
	<var name="feeAreaCode2" expr="''"/>
	<var name="feeAreaCode3" expr="''"/>
	<var name="feeNO1" expr="''"/>
	<var name="feeNO2" expr="''"/>
	<var name="feeNO3" expr="''"/>
	<var name="waveID" expr="''"/>
	<var name="endTime" expr="''"/>
	<var name="spID" expr="'0'"/>
	<var name="spServiceID" expr="''"/>
	<var name="pageFlag" expr="''"/>
	<var name="bodyreserve1" expr="''"/>
	<var name="bodyreserve2" expr="''"/>
	<var name="bodyreserve3" expr="''"/>
	<var name="bodyreserve4" expr="''"/>
	<var name="bodyreserve5" expr="''"/>
	<var name="bodyreserve6" expr="''"/>
	<var name="bodyreserve7" expr="''"/>
	<var name="bodyreserve8" expr="''"/>
	<var name="bodyreserve9" expr="''"/>
	<!--华为平台新增随路数据 -->
	<var name="arrAgentData2" expr="''"/>
	<var name="ringStartTime" expr="''"/>
	<var name="ringEndTime" expr="''"/>
	<var name="statecode" expr="''"/>
	<var name="queueFlag" expr="'0'"/>
	<!-- t_log_auto -->
	<var name="logStartTime" expr="''"/>
	<var name="logEndTime" expr="''"/>
	<var name="queueStartTime" expr="''"/>
	<var name="queueEndTime" expr="''"/>
	<var name="callAgentStartTime" expr="''"/>
	<var name="callAgentEndTime" expr="''"/>
	<var name="agentAnswerTime" expr="''"/>
	<var name="logAgentScore" expr="'0'"/>
	<var name="operID" expr="''"/>
	<var name="agentDuration" expr="''"/>
	<var name="agentShortPhone" expr="''"/>
	<var name="district" expr="''"/>
	<var name="districtCode" expr="''"/>
	<var name="queueTimes" expr="0"/>
	<var name="queueOverTimes" expr="0"/>
	<var name="queueRefTimes" expr="0"/>
	<var name="queueNoAnTimes" expr="0"/>
	<var name="appriseTimes" expr="0"/>
	<var name="endReason" expr="'0'"/>
	<var name="lastOperID" expr="'0'"/>
	<var name="pageFlag" expr="'0'"/>
	<var name="DifKey" expr="''"/>
	<!-- t_log_subauto -->
	<var name="logTranPhone" expr="''"/>
	<var name="logPhone1" expr="''"/>
	<var name="logPhone2" expr="''"/>
	<var name="logPhone3" expr="''"/>
	<var name="logPhone4" expr="''"/>
	<var name="logTranStartTime" expr="'0'"/>
	<var name="logTranEndTime" expr="'0'"/>
	<var name="logTranAnswerTime" expr="''"/>
	<var name="logTranDurationTime" expr="''"/>
	<!-- T_AUTO_BELONGDB -->
	<var name="skill" expr="'0'"/>
	<var name="vipSkill" expr="''"/>
	<var name="serviceKey" expr="''"/>
	<var name="welWord" expr="''"/>
	<var name="welTone"/>
	<var name="strRes1" expr="''"/>
	<var name="strRes2" expr="''"/>
	<var name="strRes3" expr="''"/>
	<!-- 1主叫挂机，2被叫挂机 -->
	<var name="callEndType" expr="''"/>
	<!-- 取脚本文件失败 -->
	<catch event="error.badfetch">
		<log label="root">
			root:error.badfetch
		</log>
		<assign name="callEndType" expr="'1'"/>
		<goto next="#exitCall"/>
	</catch>
	<!-- 语法文件错误 -->
	<catch event="error.grammar.addfailed">
		<log label="root">
			error.grammar.addfailed
		</log>
		<assign name="callEndType" expr="'1'"/>
		<goto next="#toLog"/>
	</catch>
	<catch event="diconnectCalling">
		<!-- 释放主叫资源，并引起connection.disconnect.hangup事件 -->
		<log label="root">
			event:diconnectCalling
		</log>
		<assign name="callEndType" expr="'2'"/>
		<goto next="#toLog"/>
	</catch>
	<catch event="logAuto">
		<!-- 此事件主叫、被叫资源已经释放 -->
		<log label="root">
			event:logAuto
		</log>
		<assign name="callEndType" expr="'1'"/>
		<goto next="#toLog"/>
	</catch>
	<catch event="connection.disconnect.hangup">
		<log label="root">
			event:connection.disconnect.hangup
		</log>
		<assign name="callEndType" expr="'1'"/>
		<goto next="#toLog"/>
	</catch>
	<script>

 <![CDATA[		function isDigit(s) {
		var r,re;
		re = /\d*/i; //\d表示数字,*表示匹配多个数字
		r = s.match(re);
		return (r==s)?true:false;
	}
	 function getDigitPath(vf)
	 {
	 	if (vf == '')
	 		return "";
	  return digitWavPath + vf;
	 }
     
      function getTitleTone(vf)
	 {
	 	if (vf == '')
	 		return "";
	  return TitleTonePath + addWAV(vf);
	 }
         
    function getGroupCard(vf)
	 {
	 	if (vf == '')
	 		return "";
	  return GroupCardPath + addWAV(vf);
	 }
	 
	  function getGroupAD(vf)
	 {
	 	if (vf == '')
	 		return "";
	  return GroupADPath + addWAV(vf);
	 }
	 
	  function getFullAudio(vf)
	 {
	 	if (vf == '')
	 		return "";
	  return AudioPath + vf;
	 }
	 
	
		
	  function trim(str){  //删除左右两端的空格   
			return str.replace(/(^\s*)|(\s*$)/g, "");   
		}
		
	 function isMobilePhone(phoneNum) {
        
          if (phoneNum.length==11&&(phoneNum.substr(0,2)=='13'||phoneNum.substr(0,2)=='15'||phoneNum.substr(0,2)=='18'))
		  return 1;
		  else  if (phoneNum.length==12&&(phoneNum.substr(0,3)=='013'||phoneNum.substr(0,3)=='015'||phoneNum.substr(0,3)=='018'))
		  return 1;
		  else
		  return 0;
		
	}
	
	
	function addWAV(wavFile) {
        
          
          if (wavFile == '')
	 		return "";
         	 else  if (wavFile.length<5||wavFile.substr(wavFile.length-4,4)!='.wav')
		  return wavFile+'.wav';	 
		  else
		  return wavFile;
		
	}

		function FormatNum(phoneNO,areaNum) {
		
		var strAreaNum=trim(areaNum);
		var retPhoneNO=trim(phoneNO);

		if (retPhoneNO.length==0)
		{
		var retString="";
		return retString;
		}
		
			if(isMobilePhone(retPhoneNO)&&retPhoneNO.substr(0,1)=='0')
				//带0的手机号码 
		{
		return retPhoneNO.substr(1,11);
		}
		
			if(retPhoneNO.substr(0,1)!='0'&&isMobilePhone(retPhoneNO))
		//不带0的手机号码
		return retPhoneNO;
		
		if (retPhoneNO.substr(0,3)=='800'||retPhoneNO.substr(0,3)=='400')
		
	    return retPhoneNO;
	    
		if(strAreaNum.length==0||strAreaNum.length>=5)
		return retPhoneNO;	
			
		if(strAreaNum.substr(0,1)!=0&&strAreaNum.length<=3)
		strAreaNum='0'+strAreaNum;
		

	    
	    if((retPhoneNO.length<=8)&&(retPhoneNO.substr(0,1)!='0'))
		//不带区号的电话号码
		//return strAreaNum+retPhoneNO;
		return '021'+retPhoneNO;	
		
		 if (retPhoneNO.length==15&&isMobilePhone(retPhoneNO.substr(4,11)))
				//4位区号+手机号码		
		   return retPhoneNO.substr(4,11);		
			
		 if (retPhoneNO.length==14&&isMobilePhone(retPhoneNO.substr(3,11)))
				//3位区号+手机号码		
		  return retPhoneNO.substr(3,11);	  
		  if (retPhoneNO.length==13&&isMobilePhone(retPhoneNO.substr(2,11)))
				//2位区号+手机号码		
		  return retPhoneNO.substr(2,11);   
		 
		    
		    
		    
		 if(retPhoneNO.length>9&&retPhoneNO.substr(0,1)!='0') 
		//区号不带0
		return '0'+retPhoneNO         
        else         
		 return retPhoneNO;		
	}
		
		
	function getCurrentTime(myTime) {
		 var dataObject;
		 if(myTime==null) dataObject = new Date();
		 else dataObject=myTime;
		 var Result;
		 var Temp;
		 Result="";
         Temp=dataObject.getFullYear();
			if( Temp<10 ) {Result+="0";	}
			Result+=Temp;
		 Temp=dataObject.getMonth()+1;
			if( Temp<10 ) {Result+="0";	}
			Result+=Temp;
		  Temp=dataObject.getDate();
			if( Temp<10 ) {Result+="0";	}
			Result+=Temp;
	      Temp=dataObject.getHours();
		  if( Temp<10 ) {Result+="0"; }
		  Result+=Temp;
		  Temp=dataObject.getMinutes();
		  if( Temp<10 ) {Result+="0"; }
		  Result+=Temp;
		  Temp=dataObject.getSeconds();
		  if( Temp<10 ) {Result+="0"; }
		  Result+=Temp;
		  return Result;
	      }
	      
	     
	function isSubelements(array,str1){  
	        
	for (var i=0;i<array.length;i++)
	{
	if(array[i]==str1)
	return true;
	}
	return false;
		}
]]> 		</script>
	<form id="toLog">
		<block name="logTime">
			<!-- 如果是二次排队，endReason则为9 -->
			<if cond="queueFlag=='1'&amp;&amp;endReason!='f'&amp;&amp;endReason!='a'">
				<assign name="endReason" expr="'9'"/>
			</if>
			<if cond="operID==''||operID.length&lt;2">
				<assign name="operID" expr="0"/>
			</if>
			<goto nextitem="checkADSMS"/>
		</block>
		<block name="checkADSMS">
			<assign name="logEndTime" expr="getCurrentTime()"/>
			<goto nextitem="toLogAuto"/>
			<if cond="isMobilePhone(callingNumber)==1&amp;&amp;lastOperID.length&gt;2">
				<if cond="callingNumber.substr(0,3)=='189'||callingNumber.substr(0,3)=='133'||callingNumber.substr(0,3)=='153'">
					<goto nextitem="toSendADSMS"/>
					<else/>
					<assign name="logEndTime" expr="getCurrentTime()"/>
					<goto nextitem="toLogAuto"/>
				</if>
				<else/>
				<assign name="logEndTime" expr="getCurrentTime()"/>
				<goto nextitem="toLogAuto"/>
			</if>
		</block>
		<subdialog name="toSendADSMS" src="sendADSMS.jsp" method="get">
			<param name="callingNumber" expr="callingNumber"/>
			<param name="SMSArea" expr="accessArea"/>
			<param name="SMSOperID" expr="lastOperID"/>
			<filled>
				<assign name="logEndTime" expr="getCurrentTime()"/>
				<goto nextitem="toLogAuto"/>
			</filled>
		</subdialog>
		<subdialog name="toLogAuto" src="iLogAuto.jsp" method="get" namelist="callFlowNO callingNumber district districtCode oriCalledNumber logStartTime logEndTime queueTimes queueOverTimes queueRefTimes queueNoAnTimes appriseTimes endReason operID lastOperID queueStartTime queueEndTime logAgentScore inCalledNumber skill accessArea  pageFlag agentAnswerTime VIPFlag DifKey">
			<filled>
				<if cond="logSubAutoFlag=='1'">
					<goto nextitem="toLogSubAuto"/>
				</if>
				<if cond="callEndType=='2'">
					<goto next="disconnectCall"/>
					<elseif cond="callEndType=='1'"/>
					<goto next="exitCall"/>
				</if>
			</filled>
		</subdialog>
		<subdialog name="toLogSubAuto" src="iLogSubAuto.jsp" method="get" namelist="callFlowNO firstType secondType district callingNumber outCallingNumber inCalledNumber calledNumber logPhone1 logPhone2 logPhone3 logPhone4 logCallBeginTime logTranStartTime logTranEndTime logTranResult operID logStartTime feeAreaNO feeNO spID accessArea pageFlag">
			<filled>
				<if cond="callEndType=='2'">
					<goto next="disconnectCall"/>
					<elseif cond="callEndType=='1'"/>
					<goto next="exitCall"/>
				</if>
			</filled>
		</subdialog>
	</form>
	<form id="disconnectCall">
		<block name="disconnect">
			<disconnect/>
			<exit/>
		</block>
	</form>
	<form id="exitCall">
		<block name="exit">
			<exit/>
		</block>
	</form>
</vxml>
