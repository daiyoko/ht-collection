<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0" application="root.jsp">
	<property name="inputmodes" value="dtmf"/>
	<var name="tranAgentTimes" expr="0"/>
	<var name="agentDuration" expr="0"/>
	<var name="retResult" expr="'FAILURE'"/>
	<var name="isQueuing"/>
	<catch event="connection.disconnect.hangup">
		<if cond="isQueuing=='1'">
			<assign name="retResult" expr="'isQueuing'"/>
			<else/>
			<assign name="retResult" expr="'logAuto'"/>
		</if>
		<return namelist="retResult endReason queueTimes"/>
	</catch>
	<form id="callAgent">
		<var name="agentPhoneNumber"/>
		<var name="agentWav"/>
		<block>
			<log label="toAgent">
				callAgent:
				<value expr="agentWav"/>
				,
				<value expr="agentPhoneNumber"/>
			</log>
			<assign name="queueStartTime" expr="getCurrentTime()"/>
			<!-- 排队中挂机 -->
			<assign name="endReason" expr="'3'"/>
			<goto nextitem="preAgent"/>
		</block>
		<block name="preAgent">
			<!-- 排队中挂机 -->
			<assign name="endReason" expr="'3'"/>
			<assign name="queueTimes" expr="queueTimes+1"/>
			<assign name="isQueuing" expr="'0'"/>
			<goto nextitem="agent"/>
		</block>
		
		<object name="agent" classid="method://huawei/Other/RequestRouting" >
		
			<!-- 路由类型 1－收号信息、2－用户技能需求、3－座席工号、4－人工台求助 -->
			<param name="RoutingType" value="2"/>
			
			<!-- 路由信息 1－流程接入码或被叫号码、2－技能队列名称（在配置台查看）、3－座席的工号、4－路由信息为空，但需在配置台的流程配置求助类型 -->
			<param name="RoutingInfo" value="voice1"/>
			
			<!-- WaitReturn是否等待返回，0表示不等待返回，1表示等待返回，10表示路由转本IVR -->
			<param name="WaitReturn" value="1"/>
			
			<!-- QueueFlag是否排队标记，0表示不排队，1表示排队 -->
			<param name="QueueFlag" value="1"/>
			
			<filled>
				<assign name="isQueuing" expr="'0'"/>
				<assign name="tranAgentTimes" expr="tranAgentTimes+1"/>
				<log label="toAgent">
					<value expr="agent"/>
				</log>
				<!-- 路由成功 -->
				<if cond="agent=='OPR_SUCCESS'">
					<clear namelist="agent"/>
				<!-- 用户挂机 -->
				<elseif cond="agent=='USER_HOOK'"/>
					<assign name="endReason" expr="'9'"/>
					<throw event="logAuto"/>
					<goto next="#returnResult"/>				
				<elseif cond="agent=='OPR_NOTIFY'"/>
					<log>人工台转回</log>
					<assign name="endReason" expr="'9'"/>
					<assign name="retResult" expr="'SUCCESS'"/>
					<goto next="#returnResult"/>
				<else/>
					<goto nextitem="callAgentFail"/>
				</if>
			</filled>
		</object>
		<block name="callAgentFail">
			<assign name="endReason" expr="'5'"/>
			<assign name="isQueuing" expr="'1'"/>
			<if cond="tranAgentTimes==3">
				<assign name="endReason" expr="'c'"/>
				<prompt>
					<audio expr="getFullAudio('24.wav')">
						系统忙，谢谢使用，再见
					</audio>
				</prompt>
				<throw event="diconnectCalling"/>
				<else/>
				<assign name="endReason" expr="'b'"/>
				<goto nextitem="callAgentAg"/>
			</if>
		</block>
		<field name="callAgentAg" type="digits?minlength=1;maxlength=1">
			<property name="inputmodes" value="dtmf"/>
			<property name="timeout" value="10"/>
			<property name="termchar" value="#"/>
			<prompt>
				<audio expr="getFullAudio('21.wav')">
					话务忙，继续等待请按1，结束请挂机
				</audio>
			</prompt>
			<filled>
				<if cond="callAgentAg==1">
					<clear namelist="callAgentAg agent"/>
					<goto nextitem="preAgent"/>
					<else/>
					<clear namelist="callAgentAg agent"/>
					<prompt>
						<audio expr="getFullAudio('22.wav')">
							输入错，请重新输入
						</audio>
					</prompt>
					<goto nextitem="callAgentAg"/>
				</if>
			</filled>
			<catch event="nomatch">
				<throw event="noinput"/>
			</catch>
			<catch event="noinput" count="1,2">
				<prompt>
					<audio expr="getFullAudio('22.wav')">
						输入错，请重新输入
					</audio>
				</prompt>
				<reprompt/>
			</catch>
			<catch event="noinput" count="3">
				<assign name="endReason" expr="'c'"/>
				<prompt>
					<audio expr="getFullAudio('23.wav')">
						谢谢使用，再见！
					</audio>
				</prompt>
				<!--<throw event="diconnectCalling"/>-->
				<assign name="retResult" expr="'secQueuet'"/>
				<return namelist="retResult endReason queueTimes"/>
			</catch>
		</field>
	</form>
	<form id="returnResult">
		<block>
			<return namelist="retResult endReason queueTimes"/>
		</block>
	</form>
</vxml>
