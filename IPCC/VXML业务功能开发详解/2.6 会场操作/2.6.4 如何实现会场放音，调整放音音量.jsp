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
            		<clear namelist="joinconf connectres"/>
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

		<!-- 会场放背景音 -->
		<object name="connectres" classid="method://huawei/Conf/ConfStartPlay" expr="true">
			<param name="ConfNO" expr="curConfNo"/>
			<param name="PlayPara" value="y:/wait.wav"/>
			<filled>
				<if cond="connectres=='SUCCESS'">
					<clear namelist="rejustVolume CollectCallee ProcessCollect"/>
				</if>
			</filled>
		</object>

		<!-- 对会场播放音乐声音的大小进行调节，会场用户的说话声音不受影响 -->
		<object name="rejustVolume" classid="method://huawei/Conf/ConfRejustPlayVolume" expr="true">
			<!-- 在期望音量和相对调节值都存在的情况下，平台将采用期望音量的方式进行调节 -->
			<!-- 会场号 -->
			<param name="ConfNO" expr="curConfNo"/>
			<!-- 会场录音的音量。 期望的会场录音的音量。目前支持的范围为92 ～ 107-->
			<param name="PlayVolume" expr="'102'"/>
			<!-- 相对调节值 正数增加当前录音音量，负数降低当前录音音量。默认值为0-->
			<param name="VolumeOffset" expr="'3'"/>
			<filled>
				<if cond="rejustVolume=='SUCCESS'">
					<log>调节会场放音音量成功</log>
				<else/>
					<log>调节会场放音音量成功</log>
				</if>
			</filled>
		</object>
				
		<!-- 会场通道收号 -->
		<object name="CollectCallee" classid="method://huawei/Conf/CollectDigit" expr="true">
            <param name="ConfNO"   expr="curConfNo"/>
            <param name="ChannelNO" expr="channel1"/>
            <filled>
                <if cond="CollectCallee == 'SUCCESS'">
                    <clear namelist="ProcessCollect"/>
                </if>
            </filled>
        </object>    
        
        <!-- 收号事件等待处理 -->
       <var name="outputinfo"/>
       <object name="ProcessCollect" classid="method://huawei/Other/ProcessEvent" expr="true">
            <param name="OutputInfo"    expr="outputinfo"/>
            <filled>
            	<if cond="ProcessCollect=='CP_USERDIALING'">
            		<log>通道收号值为:<value expr="outputinfo"/></log>
            		 <if cond ="outputinfo=='1'">
            		 	<clear namelist="stopcollectdigit stopPlay"/>
            		 <else/>
            		 	<clear namelist="CollectCallee ProcessCollect"/>
            		 </if>
            	<elseif cond="ProcessCollect=='CP_PLAYEND'"/>
            		<log>会场放音结束</log>
            		<goto nextitem="processEvent"/>
            	</if>
            </filled>
       </object>
       <!-- 停止收号 -->
		<object name="stopcollectdigit" classid=" method://huawei/Conf/StopCollectDigit" expr="true">
		<param name="ConfNO" expr="curConfNo"/>
		<param name="ChannelNO" expr="channel1"/>
		</object>
		
		<!-- 停止放音 -->
       <object name="stopPlay" classid="method://huawei/Conf/ConfStopPlay" expr="true">
			<param name="ConfNO" expr="curConfNo"/>
		</object>

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