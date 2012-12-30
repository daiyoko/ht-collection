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
			
			<filled>
				<if cond="joinconf=='SUCCESS'">
					<clear namelist="changeUserMode"/>
				</if>
			</filled>
		</object>

		<!-- 改变通道属性 -->
		<object name="changeUserMode" classid="method://huawei/Conf/ChangeUserMode" expr="true">
			<!-- 会场号 -->
			<param name="ConfNO" expr="curConfNo"/>
			<!-- 连接方设备通道号,通常是做为发起方 -->
			<param name="SrcChannelNO" expr="channel1 "/>
			<!-- 目标方设备通道号 
				说明: 当只改变单方属性时，该参数可以不指定，
					  在实现“悄悄话”、“教练/学生”模式时需要指定该参数
			 <param name="DestChannelNO" expr=" DestChannelNO "/> -->
			<!-- 连接类型 1：只听 2：只说 3：听说 4：不听不说 5：教练/学生模式 6：悄悄话 9：耳语 默认值为3。 -->
			<param name="ConnMode" value="1"/>
			<filled>
				<if cond="changeUserMode=='SUCCESS'">
					<log>改变通道属性 成功</log>
				<else/>
					<log>改变通道属性 失败</log>
				</if>
			</filled>
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