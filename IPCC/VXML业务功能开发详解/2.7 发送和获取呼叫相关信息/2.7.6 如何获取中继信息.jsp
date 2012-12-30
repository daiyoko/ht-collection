<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
    <form id="main">
        <var name="module"/>
		<var name="trunkno"/>
		<var name="callid"/>
		<object name="GetTrunkInfo" classid="method://huawei/Other/GetTrunkInfo">
			<!-- 省略该参数，默认是当前呼叫的SSP -->
			<!-- param name="SSP" expr="ssp"/ -->
			<param name="ModuleNO" expr="module"/>
			<param name="TrunkNO" expr="trunkno"/>
			<param name="CallID" expr="callid"/>
			<filled>
				<if cond="GetTrunkInfo=='SUCCESS'">
					<log>模块号:<value expr="module"/></log>
					<log>中继号:<value expr="trunkno"/></log>
					<log>呼叫ID:<value expr="callid"/></log>
				<else/>
					<exit/>
				</if>
			</filled>
		</object>
    </form>
</vxml>
