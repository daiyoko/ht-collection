<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
    <form id="main">
        <var name="curssp"/>
		<!-- 获取当前SSP -->
        <object name="getcurssp" classid="method://huawei/Other/GetCurSSP">
			<!-- 将当前SSP存放再curssp变量中 -->
			<param name="SSP" expr="curssp"/>
			<filled>
				<log>当前SSP为:<value expr="curssp"/></log>
			</filled>
		</object>
    </form>
</vxml>
