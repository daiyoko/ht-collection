<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
    <form id="main">
        <var name="curssp"/>
		<!-- 获取当前SSP -->
        <object name="getcurssp" classid="method://huawei/Other/GetCurSSP">
			<!-- 将当前SSP存放再curssp变量中 -->
			<param name="SSP" expr="curssp"/>
			<filled>
			<!-- 使用<log>标签实现日志打印 其中label和expr属性可选,标签内的内容为context-->
				<log >当前SSP:<value expr="curssp"/></log>
				<log label="当前SSP" expr="curssp"></log>
			</filled>
		</object>
    </form>
</vxml>
