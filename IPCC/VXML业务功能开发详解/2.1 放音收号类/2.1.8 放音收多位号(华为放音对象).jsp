<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
	<form>
		<!-- 呼叫应答 -->
		<object name="myAnswer" classid="method://huawei/Call/Answer">
			<param name="ChargeIndicator" value="0"/>
			<filled>
				<if cond="myAnswer != 'SUCCESS'">
					<throw event="exit"/>
				</if>
			</filled>
		</object>
		<!-- 放音收号 -->
		<var name="outputinfo"/>
		<object name="vpplaydrv" classid="method://huawei/InOutPut/VPPlayDrv">
			<!-- 放音的内容或对应语音编码 -->
            <param name="MaxDigit"  value="3"/>
            <param name="MinDigit"  value="2"/>     
            <param name="InterTime" value="5"/>
            <param name="FirstTime" value="20"/>
            <param name="EndDigit" value="#"/>
            <param name="CancelDigit" value="*"/>
			<param name="PlaySentence" value="y:\wait.wav"/>
			<!-- 收集到的用户输入的信息返回值 -->
			<param name="OutputInfo" expr="outputinfo"/>
			<filled>
				<log>您输入的号码是：<value expr="outputinfo"/></log>
				<if cond="'USER_HOOK'==vpplaydrv">
					<log>用户挂机</log>
                   <throw event="exit"/>
               <elseif cond="'USER_DIALING'==vpplaydrv"/>
               		<!-- 拨号和位间收号超时
               			 如果位间收号超时后，已收的号小于最小收号位数，则收号结果为空
               			 如果已经大于等于最小收号位数，则收号结果取已经收的号。
               		 -->
               		<log>收号返回</log>
                   <throw event="exit"/>
                   <!-- 只有当MaxDigit=0时才触发 -->
               <elseif cond="'PLAY_END'==vpplaydrv"/>
					<log>放音结束</log>
                   <throw event="exit"/>                
               <elseif cond="'TIME_OUT'==vpplaydrv"/>
               		<!-- 首位收号超时 -->
					<log>超时</log>
                   <throw event="exit"/>                 
                <elseif cond="'ERROR'==vpplaydrv"/>
 					<log>出错</log>
                   <throw event="exit"/>     
                <!-- 只在参数OutputInfo 缺省时才有该返回值 -->            
                <elseif cond="'SUCCESS'==vpplaydrv"/>
                	
					<log>发送消息成功</log>
                   <throw event="exit"/>                   	
               </if>
			</filled>
		</object>
	</form>
		
	
</vxml>