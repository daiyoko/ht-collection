<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
		<var name="curSSP"/>
		<var name="callee_SSP"/>
		<var name="curConfNo"/>
	<form id="Begin_callout">
		<!-- 获取当前呼叫SSP -->
		<object name="getcurssp" classid="method://huawei/Other/GetCurSSP">
			<param name="SSP" expr="curSSP"/>
		</object>
		<!--创建会场-->
		<object name="createconf" classid="method://huawei/Conf/CreateConf">
			<!-- 会场号 -->
			<param name="ConfNO" expr="curConfNo"/>
			<!-- 会场通道数 -->
            <param name="ChannelNum" expr="'2'"/>
             <!-- 变声标志,0表示不变声,默认为0 -->
            <param name="CVFlag" expr="'0'"/>
            <filled>
            	<if cond="createconf=='SUCCESS'">
            		<clear namelist="joinconf"/>
            	<else/>
            		<exit/>
            	</if>
            </filled>
		</object>


		<!--外呼-->
		<object name="callout" classid="method://huawei/Call/CallOut">
			<param name="CLI" expr="'112'"/>
			<param name="CLD" expr="'7002'"/>
			<param name="SSP" expr="callee_SSP"/>

			<filled>				
				<if cond="callout=='HOOK_OFF'">
					<log expr="'hook off and go on ' + callee_SSP" />
					<clear namelist="joinconf joinconf2"/>
				<else/>
					<log expr="'not hook off and return'"/>
					<goto next="#callerRelease"/>					
				</if>
			</filled>
		</object>
		
		<var name="channel1"/>
		<var name="channel2"/>
		<var name="curDelChannel" expr="'0'"/>
		<!--主叫用户加入会场-->
		<object name="joinconf" classid="method://huawei/Conf/ConfAddUser" expr="true">
			<!-- 会场号 -->
			<param name="ConfNO" expr="curConfNo"/>
			<!-- 连接方SSP -->
			<param name="SrcSSP" expr="callee_SSP"/>
			<!-- 连接方类型 0表示主叫方,目前只支持设置0 -->
			<param name="ConnPartyType" value="0"/>
			<!-- 返回用户在会场中的通道号 -->
			<param name="ChannelNO" expr="channel1"/>
			<filled>
				<if cond="joinconf=='SUCCESS'">
					<clear namelist="connectres"/>
				</if>
			</filled>
		</object>
		
		<!--被叫用户加入会场-->
		<object name="joinconf2" classid=" method://huawei/Conf/ConfAddUser" expr="true">
			<!-- 会场号 -->
			<param name="ConfNO" expr="curConfNo"/>
			<!-- 连接方SSP -->
			<param name="SrcSSP" expr="curSSP"/>
			<!-- 连接方类型 0表示主叫方,目前只支持设置0 -->
			<param name="ConnPartyType" value="0"/>
			<!-- 返回用户在会场中的通道号 -->
			<param name="ChannelNO" expr="channel2"/>
		</object>
		
		<!-- 会场通道放音 -->		
		<object name="connectres" classid="method://huawei/Conf/ConfStartChanPlay" expr="true">
			<param name="ConfNO" expr="curConfNo"/>
			<param name="ChannelNO" expr="channel1" />
			<param name="PlayPara" value="y:/wait.wav "/>
			<filled>
				<if cond="connectres=='SUCCESS'">
					<clear namelist="rejustChannelVolume"/>
				</if>
			</filled>
		</object>
		
		<!-- 该调整会影响通道放音的大小，也会影响通道用户说话声音的大小 -->
		<object name="rejustChannelVolume" classid="method://huawei/Conf/RejustChannelVolume">
			<!-- 在期望音量和相对调节值都存在的情况下，平台将采用期望音量的方式进行调节 -->
			<!-- 会场号 -->
			<param name="ConfNO" expr="curConfNo"/>
			<!-- 调整音量的通道号 -->
			<param name="ChannelNO" expr="channel1"/>
			<!-- 会场录音的音量。 期望的会场录音的音量。目前支持的范围为92 ～ 107-->
			<param name="PlayVolume" expr="'102'"/>
			<!-- 相对调节值 正数增加当前录音音量，负数降低当前录音音量。默认值为0-->
			<param name="VolumeOffset" expr="'3'"/>
			<filled>
				<if cond="rejustVolume=='SUCCESS'">
					<log>调节会场通道放音音量成功</log>
				<else/>
					<log>调节会场通道放音音量成功</log>
				</if>
			</filled>
		</object>
		
		<object name="ProcessRBT" classid="method://huawei/Other/ProcessEvent" >
			<param name="OutputInfo" expr="outputinfo"/>
			<filled>
				<if cond="ProcessRBT=='USER_HOOK'">
					<if cond="outputinfo==curSSP">
						<goto next="#callerRelease"/>
					<else/>
						<assign name="curDelChannel" expr="channel2"/>
						<clear namelist="delUser releaseCallSSP"/>
					</if>
				<else/>
					<clear namelist="ProcessRBT"/>
				</if>
			</filled>
		</object>


		<!-- 用户退出会场 -->
		<object name="delUser" classid=" method://huawei/Conf/ConfDelUser" expr="true">
			<param name="ConfNO" expr="curConfNo"/>
			<param name="ChannelNO" expr="curDelChannel"/>
		</object>
		
		<object name="releaseCallSSP" classid="method://huawei/Call/Disconnect" expr="true">
			<!-- 挂机释放 -->
			<param name="Cause" value="4"/>
			<param name="SSP" expr="outputinfo"/>
			<filled>
				<clear namelist="ProcessRBT"/>
			</filled>
		</object>
	</form>
	
	<form id="callerRelease">
		<block>
			<log>ssp:<value expr="curSSP"/></log>
			<log>outssp:<value expr="callee_SSP"/></log>
		</block>
		<object name="releaseCaller" classid="method://huawei/Call/Disconnect" >
			<!-- 挂机释放 -->
			<param name="Cause" value="4"/>
			<param name="SSP" expr="curSSP"/>
		</object>
		
		<object name="releaseCallee" classid="method://huawei/Call/Disconnect" >
			<!-- 正常拆线 -->
			<param name="Cause" value="0"/>
			<param name="SSP" expr="callee_SSP"/>
		</object>
		<filled>
			<goto next="#delConf"/>
		</filled>
	</form>
	
	
	<form id="delConf">
		<block>
			<log>confNo:<value expr="curConfNo"/></log>
		</block>
		<!-- 释放会场 -->
		<object name="releaseConf" classid="method://huawei/Conf/ReleaseConf">
			<param name="ConfNO" expr="curConfNo"/>
			<filled>
				<if cond="releaseConf=='SUCCESS'">
					<log>释放会场成功</log>
				</if>
			</filled>
		</object>
	</form>
</vxml>