<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
	<form id="main">
		<var name="timeout" expr="10"/>
		<subdialog name="sub_collectDigit" src="CollectDigit.jsp" method="post" namelist="timeout">
			<param name="testInfo" expr="'测试'"/>
			<filled>
				<log>子文档调用返回</log>
				<log>timeout:<value expr="timeout"/></log>
				<log>inputInfo:<value expr="sub_collectDigit.collect"/></log>
				<log>timeoutCount:<value expr="sub_collectDigit.timeoutCount"/></log>
				<exit/>
			</filled>
		</subdialog>
	</form>	
</vxml>