<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
    <property name="inputmodes" value="dtmf"/>

    <form id="main">
        <var name="varCallID"/>
        <!-- 获取呼叫ID -->
		<object name="GetCallID" classid="method://huawei/Other/GetCallID">
			<param name="CallID" expr="varCallID"/>
			<filled>
				<if cond="GetCallID=='SUCCESS'">
					<log>获取呼叫ID成功</log>
					<log>CALLID:<value expr="varCallID"/></log>
				<else/>
					<throw event="exit"/>
				</if>
			</filled>
		</object>
    </form>
</vxml>
