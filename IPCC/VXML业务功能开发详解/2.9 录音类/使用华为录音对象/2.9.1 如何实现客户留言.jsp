<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
    <form id="main">
		<!-- VP 录音-->
		<object name="vprecord" classid="method://huawei/InOutPut/VPRecord">
			<!-- 录音文件的文件名 最大路径长度为80 个字符 -->
			<param name="FileName" value="y:\zzyrecord\tmp.wav"/>
			<!-- 最大录音时长 默认为30 秒 -->
			<param name="MaxTime" value="20"/>
			<param name="RecordMode" value="0"/>
			<param name="RecordType" value="1"/>
			<!-- 是否允许通过按键结束录音 
				设置为1，表示允许按键结束录音，且采用阻塞式方式。即发起录音成功后，必须
						等待到用户按任意键才结束录音，此时才从此object 调用中返回。
				设置为2，表示采用非阻塞方式。即IVR下发录音操作后等待到排队机回应的ACK
						消息，就从此object 调用中返回，不会再等待收号。
				设置为其他值，表示不允许按键结束录音，且采用阻塞方式。即发起录音成功
						后，必须等待到用户挂机，或者超过设置的录音最长时间，才会从此object 调用中返回。
				测试发现其他值，只有0有效。
			-->
			<param name="DtmfEnd" 	value="0"/>
			<!-- 录音模式 默认为0
				 0 表示覆盖
				 1 表示追加方式
			 -->
			<param name="RecordMode" value="0"/>
			<!-- 录音类型 -->
			<param name="RecordType" value="65"/>
			<filled>
				<if cond="vprecord=='USER_HOOK'">
					<log>用户挂机</log>
					<exit/>
				<elseif  cond="vprecord=='RECORD_END'"/>
					<log>录音结束</log>
					<exit/>
				<elseif  cond="vprecord=='RECORD_ERROR'"/>
					<log>录音失败</log>
					<exit/>
				<elseif  cond="vprecord=='TIME_OUT'"/>
					<log>超时</log>
				<elseif  cond="vprecord=='ERROR'"/>	
					<log>错误</log>			
					<exit/>						
				</if>
			</filled>
		</object>
    </form>
</vxml>
