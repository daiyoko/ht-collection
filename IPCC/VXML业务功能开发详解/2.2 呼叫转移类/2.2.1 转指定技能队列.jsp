<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
	<form id="transToQueue">
	
		<object name="ROUT" classid="method://huawei/Other/RequestRouting" >
		
			<!-- 路由类型 1－收号信息、2－用户技能需求、3－座席工号、4－人工台求助 -->
			<param name="RoutingType" value="2"/>
			
			<!-- 路由信息 1－流程接入码或被叫号码、2－技能队列名称（在配置台查看）、3－座席的工号、4－路由信息为空，但需在配置台的流程配置求助类型 -->
			<param name="RoutingInfo" value="voice1"/>
			
			<!-- WaitReturn是否等待返回，0表示不等待返回，1表示等待返回，10表示路由转本IVR -->
			<param name="WaitReturn" value="1"/>
			
			<!-- QueueFlag是否排队标记，0表示不排队，1表示排队 -->
			<param name="QueueFlag" value="1"/>
			
			<filled>
				<if cond="ROUT=='OPR_SUCCESS'">
					<clear namelist="SuccessResult"/>
				</if>
			</filled>
		</object>
		
		<block name="SuccessResult" expr="true">
			<exit/>
		</block>
	</form>
</vxml>
