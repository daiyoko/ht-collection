<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
	<form id="transToSubIvr">
		
		<var name="param" expr="Object()"/>
		
		<block>
			<assign name="param.type" expr="'String'"/>
			<assign name="param.value" expr="'测试'"/>
			<assign name="param.size" expr="4"/>
		</block> 
		<var name="nPackLen" expr="0"/>
		<object name="Pack" classid="method://huawei/Other/Pack">
			<param name="PackLen" expr="nPackLen"/>
			<param name="paramname" expr="param"/>
		</object>
		<!-- 业务转移 -->
		<object name="transferService" classid="method://huawei/Other/TransferService">
			<!-- 子业务流程接入码 -->
			<param name="AccessCode" value="5033"/>
			<filled>
				<if cond="transferService=='SUCCESS'">
					<throw event="connection.disconnect.transfer"/>
				</if>
			</filled>
		</object>
		
	</form>
</vxml>
