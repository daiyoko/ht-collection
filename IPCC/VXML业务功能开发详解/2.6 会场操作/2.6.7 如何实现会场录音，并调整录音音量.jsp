<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
<script>
	function getFileName(){
		 var date = new Date();
		 var recordPath = "d:";
    	//录音文件名
   		 var recordName = date.getYear().toString()+
   		 (date.getMonth()+1).toString()+
   		 date.getDate().toString()+
   		 date.getUTCMilliseconds().toString()+".v3";
   		 
   		 recordName = recordPath +"/"+recordName;

   		 return recordName;
	}
</script>
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
            		<clear namelist="startconfrecord joinconf rejustVolume"/>
            	<else/>
            		<exit/>
            	</if>
            </filled>
		</object>
		
		<!--启动会场录音-->
		<object name="startconfrecord" classid="method://huawei/Conf/ConfRecord" expr="true">
			<!-- 会场号 -->
			<param name="ConfNO" expr="curConfNo"/>
			<!-- 录音格式 l 
				2：24K VOX
				4：64K Line PCM
				8：32K VOX
				16：Alaw PCM
				默认值为2。 -->
			<param name="RecordFormat" value ="2"/>
			<!-- 录音类型 
			 	1：IVR 指定文件名
				15：业务指定文件名
				默认值为1。建议使用15。-->
			<param name="RecordType" value ="15"/>
			<!-- 录音模式 0表示覆盖,1表示追加,默认为0 -->
			<param name="RecordMode" value="0"/>
			<!-- 最大录音时长 。默认为30 秒。0 表示无限制录音，直到停止录音的命令下放 -->
			<param name="MaxTime" value="0"/>
			<!-- 当"RecordType”=“1”时，“FileName”为输出参数，表示平台返回的录音文件名；
				 当“RecordType”=“15”时，FileName 为输入参数，表示录音文件的指定存放位置。
				 “FileName”支持的最大长度为145 个字节 -->
			<param name="FileName" expr="getFileName()"/>
			<param name="RecordBack" value="1"/>
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
		
		<!-- 调整会场录音音量 -->
		<object name="rejustVolume" classid="method://huawei/Conf/ConfRejustRecordVolume" expr="true">
			<!-- 在期望音量和相对调节值都存在的情况下，平台将采用期望音量的方式进行调节 -->
			<!-- 会场号 -->
			<param name="ConfNO" expr="curConfNo"/>
			<!-- 会场录音的音量。 期望的会场录音的音量。目前支持的范围为92 ～ 107-->
			<param name="RecordVolume" expr="'102'"/>
			<!-- 相对调节值 正数增加当前录音音量，负数降低当前录音音量。默认值为0-->
			<param name="VolumeOffset" expr="'3'"/>
			<filled>
				<if cond="rejustVolume=='SUCCESS'">
					<log>调节会场录音音量成功</log>
				<else/>
					<log>调节会场录音音量失败</log>
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
					<clear namelist="releaseCall stopconfrecord releaseConf"/>
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
		
		<!-- 停止会场录音 -->
		<object name="stopconfrecord" classid=" method://huawei/Conf/ConfStopRecord" expr="true">
			<param name="ConfNO" expr="curConfNo"/>
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