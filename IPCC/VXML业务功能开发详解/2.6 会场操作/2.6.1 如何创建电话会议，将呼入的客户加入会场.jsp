<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
	<form >
		<var name="curSSP"/>
		<var name="curConfNo"/>
		
		<!-- 获取当前呼叫SSP -->
		<object name="getcurssp" classid="method://huawei/Other/GetCurSSP">
			<param name="SSP" expr="curSSP"/>
		</object>

		<var name="curConfNo"/>
		
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
		
		<var name="channel1"/>
		<!--用户加入会场-->
		<object name="joinconf" classid=" method://huawei/Conf/ConfAddUser" expr="true">
			<!-- 会场号 -->
			<param name="ConfNO" expr="curConfNo"/>
			<!-- 连接方SSP -->
			<param name="SrcSSP" expr="curSSP"/>
			<!-- 连接方类型 0表示主叫方,目前只支持设置0 -->
			<param name="ConnPartyType" value="0"/>
			<!-- 返回用户在会场中的通道号 -->
			<param name="ChannelNO" expr="channel1"/>
		</object>

		<var name="outputinfo"/>
		<!-- 事件处理 -->
		<object name="processEvent" classid="method://huawei/Other/ProcessEvent">
			<param name="OutputInfo" expr="outputinfo"/>
			<filled>
				<!-- 用户挂机 -->
				<if cond="processEvent=='USER_HOOK'">
					<clear namelist="releaseCall releaseConf"/>
				<else/>
					<clear namelist="processEvent"/>
				</if>
			</filled>
		</object>
		
		<object name="releaseCall" classid="method://huawei/Call/Disconnect" expr="true">
			<!-- 挂机释放 -->
			<param name="Cause" value="4"/>
			<param name="SSP" expr="curSSP"/>
		</object>
		
		<!-- 释放会场 -->
		<object name="releaseConf" classid="method://huawei/Conf/ReleaseConf" expr="true">
			<param name="ConfNO" expr="curConfNo"/>
			<filled>
				<if cond="releaseConf=='SUCCESS'">
					<log>释放会场成功</log>
				</if>
			</filled>
		</object>
	</form>
	
</vxml>