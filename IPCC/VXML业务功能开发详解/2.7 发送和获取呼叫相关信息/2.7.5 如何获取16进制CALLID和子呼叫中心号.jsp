<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
    <form id="main">
        <var name="varCallID"/>
		<var name="varSubCCNO"/>
		<var name="varTime"/>
		<var name="varDsn"/>
		<var name="varHandle"/>
		<var name="varServer"/>
		<!-- 获取十六进制呼叫信息 -->
		<object name="getcallinfo" classid="method://huawei/Other/GetHexCallInfo">
			<!-- 十六进制呼叫ID 其中具体格式为：
			%08X%04X%02X%02X
			从前到后的分别表示如下：
			前8 位表示CallID 的ulTime 字段
			4 位表示CallID 的usDsn
			2 位表示CallID 的ucHandle
			2 位表示CallID 的ucServer-->
			<param name="CallID" expr="varCallID "/>
			<!-- 子呼叫中心号 -->
			<param name="SubCCNO" expr="varSubCCNO "/>
			<!-- CallID 中的Time 字段 -->
			<param name="Time" expr="varTime "/>
			<!-- CallID 中的Dsn 字段 -->
			<param name="Dsn" expr="varDsn "/>
			<!-- CallID 中的Handle 字段 -->
			<param name="Handle" expr="varHandle "/>
			<!-- CallID 中的Server 字段 -->
			<param name="Server" expr="varServer "/>
			<filled>
				<script>
					//计算字符串CALLID
					var strCallId="";
					var second =parseInt(varDsn)+varHandle * 1024 * 64 + varServer * 1024 * 1024 *16;
					strCallId = varTime+"-"+second.toString();
				</script>
				<if cond="getcallinfo=='SUCCESS'">
					<log>十六进制CALLID:<value expr="varCallID"/></log>
					<log>SubCCNO:<value expr="varSubCCNO"/></log>
					<log>Time:<value expr="varTime"/></log>
					<log>Dsn:<value expr="varDsn"/></log>
					<log>Handle:<value expr="varHandle"/></log>
					<log>Server:<value expr="varServer"/></log>
					<log>strCallId:<value expr="strCallId"/></log>
				<else/>
					<throw event="exit"/>
				</if>
			</filled>
		</object>
    </form>
</vxml>