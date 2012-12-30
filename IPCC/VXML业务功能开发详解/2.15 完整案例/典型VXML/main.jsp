<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0" application="root.jsp">
	<property name="inputmodes" value="dtmf"/>
	<var name="callWav"/>
	<var name="callTTS"/>
	<var name="arrCallingNumber"/>
	<var name="arrCalledNumber"/>
	<var name="SMSContent"/>
	<var name="SMSCallingNumber"/>
	<var name="SMSCalledNumber"/>
	<var name="SMSChargeNumber"/>
	<var name="SMSArea"/>
	<var name="promptWav"/>
	<var name="promptTTS"/>
	<var name="prompInfoCount"/>
	<var name="OTAFlag" expr="1"/>
	<!--  
	<form id="redirectOTA">
		<block>
			<submit next="redirectPhone.jsp" method="get"/>
		</block>
	</form>
	-->
	<form id="initialData">
		<block name="getPara">
			<assign name="inCallingNumber" expr="session.telephone.ani"/>
			<assign name="callingNumber" expr="inCallingNumber"/>
			<assign name="accessCode" expr="session.telephone.dnis"/>
			<assign name="inOriCalledNumber" expr="session.telephone.odnis"/>
			<assign name="callFlowNO" expr="session.telephone.IDNO"/>
			<assign name="logStartTime" expr="getCurrentTime()"/>
			<assign name="oriCalledNumber" expr="inOriCalledNumber"/>
			<assign name="endReason" expr="'1'"/>
			<!-- 
			<submit next="config.jsp" namelist="accessCode callingNumber logStartTime" method="get"/>
			-->
			<log>callFlowNO:<value expr="callFlowNO"/></log>
			<goto next="#welTone"/>
		</block>
	</form>
	
	<form id="welTone">
		<object name="answerCall" classid="method://huawei/Call/Answer">
			<param name="ChargeIndicator" value="0"/>
			<filled>
				<log label="main">
					answerCall
					<value expr="answerCall"/>
				</log>
			</filled>
		</object>
		<block cond="OTAFlag=='1'">
			<!--OTA卡直接入坐席-->
			<if cond="OTAPromp=='0'">
				<goto next="#toAgent"/>
				<elseif cond="OTAPromp=='1'"/>
				<goto nextitem="OTAKey"/>
				<else/>
				<goto nextitem="welToneKey"/>
			</if>
		</block>
		<block><log>OTAFlag:<value expr="OTAFlag"/></log></block>
		<block cond="OTAFlag=='2'">
			<!--其他助理平台的呼叫-->
			<if cond="assitantPlatPromp=='0'">
				<goto next="#toAgent"/>
				<elseif cond="assitantPlatPromp=='1'"/>
				<goto nextitem="OTAKey"/>
				<else/>
				<assign name="welTone" expr="speWelTone"/>
				<goto nextitem="welToneKey"/>
			</if>
		</block>
		<block cond="OTAFlag=='3'">
			<!--特殊号码的呼叫-->
			<if cond="otherPromp=='0'">
				<goto next="#toAgent"/>
				<elseif cond="otherPromp=='1'"/>
				<goto nextitem="OTAKey"/>
				<else/>
				<prompt>
					<audio expr="getFullAudio(norWelTone+'.wav')">
						<value expr="welWord"/>
					</audio>
				</prompt>
				<goto next="#toAgent"/>
			</if>
		</block>
		<field name="adToneKey" cond="adToneID!='0'" type="digits?minlength=1;maxlength=1">
			<property name="timeout" value="1s"/>
			<prompt>
				<audio expr="getFullAudio(adToneID+'.wav')">
				</audio>
			</prompt>
			<filled>
				<goto nextitem="welToneKey"/>
			</filled>
			<catch event="noinput">
				<goto nextitem="welToneKey"/>
			</catch>
		</field>
		<field name="welToneKey" cond="welTone.length&gt;0||welWord.length&gt;0" type="digits?minlength=1;maxlength=1">
			<property name="timeout" value="1s"/>
			<prompt>
				<audio expr="getFullAudio(welTone+'.wav')">
					<value expr="welWord"/>
				</audio>
			</prompt>
			<filled>
				<if cond="OTAFlag=='1'">
					<goto next="#toAgent"/>
					<else/>
					<goto nextitem="checkVipMenu"/>
				</if>
			</filled>
			<catch event="noinput">
				<if cond="OTAFlag=='1'">
					<goto next="#toAgent"/>
					<else/>
					<goto nextitem="checkVipMenu"/>
				</if>
			</catch>
		</field>
		<field name="OTAKey" type="digits?minlength=1;maxlength=1">
			<property name="inputmodes" value="dtmf"/>
			<property name="timeout" value="6"/>
			<property name="termchar" value="#"/>
			<prompt>
				<audio expr="getFullAudio(welTone+'.wav')">
				</audio>
			</prompt>
			<filled>
				<if cond="OTAKey==1">
					<goto next="#toAgent"/>
					<else/>
					<prompt>
						<audio expr="getFullAudio('22.wav')">
							输入错，请重新输入
						</audio>
					</prompt>
					<throw event="noinput"/>
				</if>
			</filled>
			<catch event="nomatch">
				<throw event="noinput"/>
			</catch>
			<catch event="noinput" count="1,2">
				<goto nextitem="OTAKey"/>
			</catch>
			<catch event="noinput" count="3">
				<audio expr="getFullAudio('55.wav')">
				</audio>
				<throw event="logAuto"/>
			</catch>
		</field>
		<block name="checkVipMenu">
			<if cond="VIPFlag=='00'">
				<goto nextitem="toMenu"/>
				<elseif cond="VIPPromp=='1'"/>
				<goto nextitem="toMenu"/>
				<else/>
				<goto next="#toAgent"/>
			</if>
		</block>
		<block name="toMenu">
			<submit next="menu.jsp" method="get"/>
		</block>
	</form>
	<form id="toAgent">
		<!--转接坐席-->
		<var name="dataInStrRes1" expr="''"/>
		<var name="dataInStrRes2" expr="callFlowNO"/>
		<var name="dataOutStrRes1" expr="''"/>
		<var name="dataOutStrRes2" expr="''"/>
		<var name="operDataType" expr="'1'"/>
		<block name="preToAgent">
			<assign name="queueStartTime" expr="getCurrentTime()"/>
			<script>
				var OTAArray = new Array(serviceKey,skill,callFlowNO,
				&quot;1
				&quot;,inCalledNumber,callingNumber,
				&quot;0
				&quot;,VIPFlag,
				&quot;
				&quot;,oriCalledNumber,
				&quot;
				&quot;,accessArea,DifKey,queueStartTime);
				toAgentMsg = OTAArray.join(
				&quot;^
				&quot;);
			</script>		
			<goto nextitem="setOperData"/>
		</block>
		<subdialog name="setOperData" src="operateData.jsp" method="post" namelist="inCalledNumber inCallingNumber toAgentMsg operDataType dataInStrRes1 dataInStrRes2">
			<filled>
				<goto nextitem="toCallAgent"/>
			</filled>
		</subdialog>
		<subdialog name="toCallAgent" src="callAgent.jsp" method="get">
			<param name="agentWav" expr="''"/>
			<param name="agentPhoneNumber" expr="skill"/>
			<filled>
				<if cond="toCallAgent.retResult=='SUCCESS'">
					<assign name="operDataType" expr="'0'"/>
					<assign name="endReason" expr="toCallAgent.endReason"/>
					<assign name="queueTimes" expr="toCallAgent.queueTimes"/>
					<goto nextitem="getOperData"/>
					<elseif cond="toCallAgent.retResult=='logAuto'"/>
					<assign name="operDataType" expr="'0'"/>
					<assign name="endReason" expr="toCallAgent.endReason"/>
					<assign name="queueTimes" expr="toCallAgent.queueTimes"/>
					<goto nextitem="getOperData"/>
					<elseif cond="toCallAgent.retResult=='secQueuet'"/>
					<assign name="endReason" expr="toCallAgent.endReason"/>
					<assign name="queueTimes" expr="toCallAgent.queueTimes"/>
					<throw event="diconnectCalling"/>
					<elseif cond="toCallAgent.retResult=='isQueuing'"/>
					<assign name="endReason" expr="toCallAgent.endReason"/>
					<assign name="queueTimes" expr="toCallAgent.queueTimes"/>
					<throw event="diconnectCalling"/>
					<else/>
					<throw event="diconnectCalling"/>
				</if>
			</filled>
		</subdialog>
		<subdialog name="getOperData" src="operateData.jsp" method="get" namelist="inCalledNumber inCallingNumber toAgentMsg operDataType dataInStrRes2">
			<filled>
				<if cond="getOperData.retResult=='0'">
					<assign name="agentData" expr="getOperData.agentData"/>
					<assign name="dataOutStrRes1" expr="getOperData.dataOutStrRes1"/>
					<assign name="dataOutStrRes2" expr="getOperData.dataOutStrRes2"/>
					<script>
						arrAgentData2=dataOutStrRes1.split(
						&quot;^
						&quot;);
					</script>
					<assign name="operID" expr="arrAgentData2[2]"/>
					<assign name="lastOperID" expr="arrAgentData2[3]"/>
					<assign name="queueEndTime" expr="arrAgentData2[4]"/>
					<assign name="ringStartTime" expr="arrAgentData2[5]"/>
					<assign name="ringEndTime" expr="arrAgentData2[6]"/>
					<assign name="agentAnswerTime" expr="arrAgentData2[7]"/>
					<assign name="statecode" expr="arrAgentData2[8]"/>
					<assign name="queueFlag" expr="arrAgentData2[9]"/>
					<assign name="queueEndTime" expr="ringStartTime"/>
					<!-- 排队成功，坐席不应答，未评价 -->
					<if cond="statecode=='2'">
						<assign name="endReason" expr="'e'"/>
						<throw event="diconnectCalling"/>
						<!-- 排队成功，坐席拒绝，未评价 -->
						<elseif cond="statecode=='3'"/>
						<assign name="endReason" expr="'d'"/>
						<throw event="diconnectCalling"/>
						<!-- 排队成功，主叫在坐席振铃时挂机 -->
						<elseif cond="statecode=='1'"/>
						<assign name="endReason" expr="'6'"/>
						<throw event="logAuto"/>
						<!-- 排队成功，坐席转接 -->
						<elseif cond="statecode=='5'"/>
						<assign name="endReason" expr="'9'"/>
						<throw event="diconnectCalling"/>
						<!--<elseif cond="statecode=='4'"/>-->
						<elseif cond="statecode=='4'"/>
						<assign name="endReason" expr="'9'"/>
						<throw event="logAuto"/>
						<elseif cond="statecode=='6'"/>
						<assign name="endReason" expr="'9'"/>
						<goto next="#agentBack"/>
					</if>
					<goto next="#agentBack"/>
					<else/>
					<assign name="endReason" expr="'3'"/>
					<throw event="logAuto"/>
				</if>
			</filled>
		</subdialog>
	</form>
	<form id="agentBack">
		<block>
			<script>
				arrAgentData=agentData.split(
				&quot;^
				&quot;);
			</script>
			<assign name="dataValid" expr="arrAgentData[0]"/>
			<assign name="firstType" expr="arrAgentData[3]"/>
			<assign name="secondType" expr="arrAgentData[4]"/>
			<assign name="calledNum" expr="arrAgentData[8]"/>
			<assign name="calledNO1" expr="arrAgentData[9]"/>
			<assign name="calledNO2" expr="arrAgentData[10]"/>
			<assign name="calledNO3" expr="arrAgentData[11]"/>
			<assign name="feeAreaCode1" expr="arrAgentData[12]"/>
			<assign name="feeAreaCode2" expr="arrAgentData[13]"/>
			<assign name="feeAreaCode3" expr="arrAgentData[14]"/>
			<assign name="feeNO1" expr="arrAgentData[15]"/>
			<assign name="feeNO2" expr="arrAgentData[16]"/>
			<assign name="feeNO3" expr="arrAgentData[17]"/>
			<assign name="waveID" expr="arrAgentData[18]"/>
			<assign name="endTime" expr="arrAgentData[21]"/>
			<assign name="spID" expr="arrAgentData[22]"/>
			<assign name="spServiceID" expr="arrAgentData[23]"/>
			<assign name="pageFlag" expr="arrAgentData[24]"/>
			<assign name="bodyreserve1" expr="arrAgentData[25]"/>
			<assign name="bodyreserve2" expr="arrAgentData[26]"/>
			<assign name="bodyreserve3" expr="arrAgentData[27]"/>
			<assign name="bodyreserve4" expr="arrAgentData[28]"/>
			<assign name="bodyreserve5" expr="arrAgentData[29]"/>
			<assign name="bodyreserve6" expr="arrAgentData[30]"/>
			<assign name="bodyreserve7" expr="arrAgentData[31]"/>
			<assign name="bodyreserve8" expr="arrAgentData[32]"/>
			<assign name="bodyreserve9" expr="arrAgentData[33]"/>
			<assign name="lastOperID" expr="arrAgentData[5]"/>
		</block>
		<block cond="dataValid=='1'">
			<prompt>
				<audio expr="getFullAudio('24.wav')">
					系统忙，谢谢使用，再见
				</audio>
			</prompt>
			<throw event="diconnectCalling"/>
		</block>
		<block>
			<if cond="firstType=='1'">
				<!--大类1：挂机-->
				<if cond="secondType=='0'">
					<!--大类1 小类0：座席无消息挂机-->
					<assign name="endReason" expr="'9'"/>
					<goto next="#agentScore"/>
					<elseif cond="secondType=='1'"/>
					<!--大类1 小类1：F8挂机-->
					<prompt>
						<audio expr="getFullAudio('42.wav')">
							我听不清楚您的说话，请用其他话机打来
						</audio>
					</prompt>
					<assign name="endReason" expr="'9'"/>
					<throw event="diconnectCalling"/>
					<elseif cond="secondType=='1'"/>
					<!--大类1 小类2：坐席挂机-->
					<assign name="endReason" expr="'9'"/>
					<goto next="#agentScore"/>
					<else/>
					<assign name="endReason" expr="'9'"/>
					<goto next="#agentScore"/>
				</if>
				<elseif cond="firstType=='4'"/>
				<!--大类4：转接-->
				<if cond="secondType=='3'">
					<!--大类4,小类3：转接-->
					<assign name="arrCalledNumber" expr="trim(bodyreserve1)+'|'+trim(bodyreserve2)+'|'+trim(bodyreserve3)"/>
					<assign name="arrCallingNumber" expr="trim(bodyreserve7)+'|'+trim(bodyreserve8)+'|'+trim(bodyreserve9)"/>
					<assign name="callWav" expr="getGroupAD(waveID)"/>
					<assign name="callTTS" expr="endTime"/>
					<goto nextitem="toCallPhone"/>
					<!--大类4,小类5：黑龙江外乎转接-->
					<elseif cond="secondType=='5'"/>
					<assign name="arrCalledNumber" expr="trim(bodyreserve1)"/>
					<assign name="arrCallingNumber" expr="trim(bodyreserve7)"/>
					<assign name="callWav" expr="''"/>
					<assign name="callTTS" expr="''"/>
					<goto nextitem="toCallPhone"/>
					<else/>
					<goto next="#agentScore"/>
				</if>
				<elseif cond="firstType=='5'"/>
				<!--大类5：短信-->
				<if cond="secondType=='2'">
					<!--大类5,小类2：短信-->
					<assign name="SMSContent" expr="bodyreserve1"/>
					<assign name="SMSCallingNumber" expr="'118114'"/>
					<assign name="SMSCalledNumber" expr="bodyreserve2"/>
					<assign name="SMSChargeNumber" expr="feeNO1"/>
					<assign name="SMSArea" expr="accessArea"/>
					<goto nextitem="toSendSMS"/>
					<else/>
					<goto next="#agentScore"/>
				</if>
				<elseif cond="firstType=='8'"/>
				<!--大类4：转接-->
				<if cond="secondType=='2'">
					<!--大类8,小类2：通信助理转接-->
					<assign name="arrCalledNumber" expr="trim(bodyreserve1)"/>
					<assign name="arrCallingNumber" expr="trim(bodyreserve7)"/>
					<assign name="callWav" expr="''"/>
					<assign name="callTTS" expr="''"/>
					<goto nextitem="toCallPhone"/>
					<elseif cond="secondType=='3'"/>
					<assign name="arrCalledNumber" expr="trim(calledNO1)+'|'+trim(calledNO2)+'|'+trim(calledNO3)"/>
					<assign name="arrCallingNumber" expr="trim(bodyreserve7)+'|'+trim(bodyreserve8)+'|'+trim(bodyreserve9)"/>
					<assign name="callWav" expr="''"/>
					<assign name="callTTS" expr="''"/>
					<goto nextitem="toCallPhone"/>
					<elseif cond="secondType=='5'"/>
					<assign name="arrCalledNumber" expr="trim(bodyreserve1)"/>
					<assign name="arrCallingNumber" expr="trim(bodyreserve7)"/>
					<assign name="callWav" expr="''"/>
					<assign name="callTTS" expr="''"/>
					<goto nextitem="toCallPhone"/>
					<else/>
					<goto next="#agentScore"/>
				</if>
				<elseif cond="firstType=='10'"/>
				<!--大类10：综合报号-->
				<if cond="secondType=='1'">
					<!--大类10,小类1：报号-->
					<assign name="promptTTS" expr="bodyreserve3"/>
					<assign name="prompInfoCount" expr="prompCount"/>
					<if cond="bodyreserve1.length&gt;0">
						<assign name="promptWav" expr="getGroupCard(bodyreserve1)"/>
						<else/>
						<assign name="promptWav" expr="''"/>
					</if>
					<if cond="bodyreserve4.length&gt;0">
						<prompt>
							<audio expr="getTitleTone(bodyreserve4)">
							</audio>
						</prompt>
						<log>
							冠名音号:
							<value expr="bodyreserve4"/>
						</log>
						<goto nextitem="toPrompt"/>
						<elseif cond="bodyreserve5.length&gt;1"/>
						<prompt>
							<value expr="bodyreserve5"/>
						</prompt>
						<goto nextitem="toPrompt"/>
						<else/>
						<goto nextitem="toPrompt"/>
					</if>
					<elseif cond="secondType=='2'"/>
					<!--大类10,小类2：企业广告-->
					<if cond="bodyreserve1.length&gt;0">
						<assign name="promptWav" expr="getGroupAD(bodyreserve1)"/>
						<else/>
						<assign name="promptWav" expr="''"/>
					</if>
					<assign name="promptTTS" expr="bodyreserve5"/>
					<assign name="prompInfoCount" expr="1"/>
					<goto nextitem="toPrompt"/>
					<elseif cond="secondType=='3'"/>
					<!--大类10,小类3：指路服务-->
					<assign name="promptWav" expr="''"/>
					<assign name="promptTTS" expr="bodyreserve1"/>
					<assign name="prompInfoCount" expr="2"/>
					<goto nextitem="toPrompt"/>
					<elseif cond="secondType=='4'"/>
					<!--大类10,小类4：灵通助理报号-->
					<assign name="promptWav" expr="''"/>
					<assign name="promptTTS" expr="bodyreserve1"/>
					<assign name="prompInfoCount" expr="2"/>
					<goto nextitem="toPrompt"/>
					<elseif cond="secondType=='5'"/>
					<!--大类10,小类5：企业总机报号-->
					<assign name="promptWav" expr="''"/>
					<assign name="promptTTS" expr="bodyreserve1"/>
					<assign name="prompInfoCount" expr="2"/>
					<goto nextitem="toPrompt"/>
					<elseif cond="secondType=='13'"/>
					<!--大类10,小类13：非号码信息报号-->
					<assign name="promptWav" expr="''"/>
					<assign name="promptTTS" expr="bodyreserve1"/>
					<assign name="prompInfoCount" expr="2"/>
					<goto nextitem="toPrompt"/>
					<else/>
					<goto next="#agentScore"/>
				</if>
			</if>
		</block>
		<block name="toCallPhone">
			<if cond="LocalArea=='0000'||LocalArea=='0000'">
				<if cond="callWav.length&gt;0||callWav&gt;0">
					<prompt>
						<audio expr="callWav">
							正在转接呼叫，请稍后
						</audio>
					</prompt>
					<elseif cond="callTTS.length&gt;0"/>
					<prompt>
						<value expr="callTTS"/>
					</prompt>
					<else/>
					<prompt>
						<audio expr="getFullAudio('39.wav')">
							正在转接呼叫，请稍后
						</audio>
					</prompt>
				</if>
				<script>
					arrCalledNumber=arrCalledNumber.split(
					&quot;|
					&quot;);
		       arrCallingNumber=arrCallingNumber.split(
					&quot;|
					&quot;);
				</script>
				<assign name="calledNumber" expr="arrCalledNumber[0]"/>
				<assign name="outCallingNumber" expr="arrCallingNumber[0]"/>
				<if cond="outCallingNumber=='118114'">
					<assign name="outCallingNumber" expr="accessArea+outCallingNumber"/>
				</if>
				<submit next="callPhoneForLN.jsp"/>
				<exit/>
				<else/>
				<goto nextitem="toBridgeCallPhone"/>
			</if>
		</block>
		
		<subdialog name="toBridgeCallPhone" src="callPhone.jsp" method="get">
			<param name="accessArea" expr="accessArea"/>
			<param name="callWav" expr="callWav"/>
			<param name="callTTS" expr="callTTS"/>
			<param name="arrCalledNumber" expr="arrCalledNumber"/>
			<param name="arrCallingNumber" expr="arrCallingNumber"/>
			<param name="userFlag" expr="VIPFlag"/>
			<filled>
				<assign name="logSubAutoFlag" expr="'1'"/>
				<assign name="logTranEndTime" expr="getCurrentTime()"/>
				<assign name="calledNumber" expr="toBridgeCallPhone.calledNumber"/>
				<assign name="logPhone1" expr="toBridgeCallPhone.logPhone1"/>
				<assign name="logPhone2" expr="toBridgeCallPhone.logPhone2"/>
				<assign name="logPhone3" expr="toBridgeCallPhone.logPhone3"/>
				<assign name="logPhone4" expr="toBridgeCallPhone.logPhone4"/>
				<assign name="outCallingNumber" expr="toBridgeCallPhone.outCallingNumber"/>
				<assign name="logCallBeginTime" expr="toBridgeCallPhone.logCallBeginTime"/>
				<assign name="logTranStartTime" expr="toBridgeCallPhone.logTranStartTime"/>
				<assign name="feeAreaNO" expr="feeAreaCode1"/>
				<assign name="feeNO" expr="feeNO1"/>
				<if cond="toBridgeCallPhone.retResult=='SUCCESS'&amp;&amp;toBridgeCallPhone.callOutInfo=='logAuto'">
					<!-- 接通并且主叫挂机 -->
					<assign name="logTranResult" expr="0"/>
					<throw event="logAuto"/>
					<elseif cond="toBridgeCallPhone.retResult=='SUCCESS'"/>
					<!-- 接通并且被叫挂机 -->
					<assign name="logTranResult" expr="0"/>
					<throw event="diconnectCalling"/>
					<elseif cond="toBridgeCallPhone.retResult=='FAILURE'&amp;&amp;toBridgeCallPhone.callOutInfo=='logAuto'"/>
					<!-- 接通不成功：接通过程主叫挂机 -->
					<assign name="logTranResult" expr="1"/>
					<throw event="logAuto"/>
					<else/>
					<assign name="logTranResult" expr="1"/>
					<prompt>
						<audio expr="getFullAudio('27.wav')">
							对不起，暂时无法接通
						</audio>
					</prompt>
					<throw event="diconnectCalling"/>
				</if>
			</filled>
		</subdialog>
		<subdialog name="toSendSMS" src="sendSMS.jsp" method="get">
			<param name="callingNumber" expr="callingNumber"/>
			<param name="SMSContent" expr="SMSContent"/>
			<param name="SMSCallingNumber" expr="SMSCallingNumber"/>
			<param name="SMSCalledNumber" expr="SMSCalledNumber"/>
			<param name="SMSChargeNumber" expr="SMSChargeNumber"/>
			<param name="SMSArea" expr="SMSArea"/>
			<param name="SMSPageFlag" expr="pageFlag"/>
			<param name="SMSOperID" expr="lastOperID"/>
			<filled>
				<if cond="toSendSMS.retResult=='SUCCESS'">
					<goto next="#agentScore"/>
					<else/>
					<throw event="diconnectCalling"/>
				</if>
			</filled>
		</subdialog>
		<subdialog name="toPrompt" src="prompt.jsp" method="get">
			<param name="promptWav" expr="promptWav"/>
			<param name="promptTTS" expr="promptTTS"/>
			<param name="prompInfoCount" expr="prompInfoCount"/>
			<filled>
				<goto next="#agentScore"/>
			</filled>
		</subdialog>
	</form>
	<form id="agentScore">
		<!--话务员评价-->
		<block name="preScore">
			<prompt>
				<audio expr="getFullAudio('2.wav')">
				</audio>
			</prompt>
		</block>
		<field name="getAgentScore" type="digits?minlength=1;maxlength=1">
			<property name="inputmodes" value="dtmf"/>
			<property name="timeout" value="10"/>
			<property name="termchar" value="#"/>
			<prompt>
				<audio expr="getFullAudio('34.wav')">
					刚才为您服务的是
				</audio>
			</prompt>
			<prompt>
				<value expr="lastOperID"/>
			</prompt>
			<prompt>
				<audio expr="getFullAudio('36.wav')">
					号
				</audio>
				<audio expr="getFullAudio('37.wav')">
					话务员
				</audio>
				<audio expr="getFullAudio('4.wav')">
				</audio>
				<audio expr="getFullAudio('35.wav')">
					满意请按1，一般请按2，不满意请按3,退出请挂机
				</audio>
			</prompt>
			<filled>
				<if cond="getAgentScore=='1'||getAgentScore=='2'||getAgentScore=='3'">
					<assign name="endReason" expr="'f'"/>
					<assign name="appriseTimes" expr="appriseTimes+1"/>
					<assign name="logAgentScore" expr="getAgentScore"/>
					<goto nextitem="endCall"/>
					<else/>
					<clear namelist="getAgentScore"/>
					<prompt>
						<audio expr="getFullAudio('22.wav')">
							输入错，请重新输入
						</audio>
					</prompt>
					<goto nextitem="preScore"/>
				</if>
			</filled>
			<catch event="nomatch">
				<throw event="noinput"/>
			</catch>
			<noinput>
				<prompt>
					<audio expr="getFullAudio('22.wav')">
						输入错，请重新输入
					</audio>
				</prompt>
				<reprompt/>
			</noinput>
			<catch event="noinput" count="3">
				<assign name="endReason" expr="'a'"/>
				<prompt>
					<audio expr="getFullAudio('23.wav')">
						谢谢使用,再见
					</audio>
				</prompt>
				<assign name="endReason" expr="'a'"/>
				<throw event="diconnectCalling"/>
			</catch>
		</field>
		<block name="endCall">
			<prompt>
				<audio expr="getFullAudio('23.wav')">
					谢谢使用,再见
				</audio>
			</prompt>
			<throw event="diconnectCalling"/>
		</block>
	</form>
</vxml>
