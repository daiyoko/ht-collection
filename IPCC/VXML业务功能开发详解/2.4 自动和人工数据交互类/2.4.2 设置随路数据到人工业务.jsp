
<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
	
	<form id="packData">
		<var name="param" expr="Object()"/>
		<block>
			<assign name="param.type" expr="'String'"/>
			<assign name="param.value" expr="'测试123abc'"/>
			<assign name="param.size" expr="10"/>
		</block> 
		<var name="nPackLen" expr="0"/>
		<object name="Pack" classid="method://huawei/Other/Pack">
			<param name="PackLen" expr="nPackLen"/>
			<param name="paramname" expr="param"/>
		</object>
		
		<!-- 取人工台数据 -->
		<object name="getData" classid="method://huawei/CallExtend/OperatorData">
			<!-- 操作方式,0表示取人工台数据,1表示设置人工台数据 -->
			<param name="OperateType" value="1"/>
			<!-- 表示人工台数据区中有效数据的长度。最大长度不能超过1024 个字节。 -->
			<param name="DataLen" value="10"/>
			<!-- 如果是设置人工台数据，该参数为输入参数，表示传递给人工台的数据；
				 如果是取人工台数据，该参数为输出参数，表示从人工台接收到的数据。
				 缺省表示使用系统参数呼叫附加信息。 -->
			<!--<param name="DataInfo" expr="dataInfo"/>  -->
			<filled>
				<log>获取数据<value expr="getData"/></log>
				<goto next="#transToQueue"/>
			</filled>
		</object>
	</form>

	<form id="transToQueue">
	
		<object name="ROUT" classid="method://huawei/Other/RequestRouting">
		
			<!-- 路由类型 1－收号信息、2－用户技能需求、3－座席工号、4－人工台求助 -->
			<param name="RoutingType" value="3"/>
			
			<!-- 路由信息 1－流程接入码或被叫号码、2－技能队列名称（在配置台查看）、3－座席的工号、4－路由信息为空，但需在配置台的流程配置求助类型 -->
			<param name="RoutingInfo" value="104"/>
			
			<!-- WaitReturn是否等待返回，0表示不等待返回，1表示等待返回，10表示路由转本IVR -->
			<param name="WaitReturn" value="0"/>
			
			<!-- QueueFlag是否排队标记，0表示不排队，1表示排队 -->
			<param name="QueueFlag" value="0"/>
			
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

