<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
    <property name="inputmodes" value="dtmf"/>

    <form id="main">
    	<!-- 主叫号 -->
        <var name="callerNo" expr="session.telephone.ani"/>
        <!-- 被叫号(流程接入码)-->
		<var name="calledNo" expr="session.telephone.dnis"/>
		<!-- 原始被叫有待测试 -->
		<var name="orgCalledNo" expr="session.telephone.odnis"/>
		
		
		<block>
			<log>主叫号:<value expr="callerNo"/></log>
			<log>被叫号(流程接入码):<value expr="calledNo"/></log>
			<log>原始被叫号:<value expr="orgCalledNo"/></log>
		</block>
		<var name="diaNum"/>
		<!-- 获取被叫号码,即用户拨号时的号码 -->
		<object name="queryCallInfo" classid="method://huawei/Other/QueryCallInfo">
			<param name="DialedNumber" expr="diaNum"/>
			<filled>
				<if cond="queryCallInfo=='SUCCESS'">
					<log>用户拨号号码:<value expr="diaNum"/></log>
				</if>
			</filled>
		</object>
		
    </form>
</vxml>
