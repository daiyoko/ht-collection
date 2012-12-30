<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
	<form>
		<!-- 发送便笺 -->
		<object name="SendMemo" classid="method://huawei/Other/SendMemo">
			<!-- 接收便笺的座席工号 -->
			<param name="AgentNO" expr="104"/>
			<param name="PackInfo" expr="'abcd欢迎,您好123'"/>
			
			<!-- 
				使用PackInfo时可以不填写ExtraDataLen
			 <param name="ExtraDataLen" expr="10"/>-->
			 <filled>
			 	<log>发送便签<value expr="SendMemo"/></log>
			 </filled>
		</object>
	</form>
</vxml>
