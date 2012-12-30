<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0" application="ICD_root.jsp">

	<form id="playdrvbagein">
		<script>
			var timeoutCount = 0;
			function countAdd(){
				timeoutCount=timeoutCount+1;
				return timeoutCount;
			}
		</script>
		<property name="interdigittimeout" value="10"/>
		<property name="inputmodes" value="dtmf"/>
		<property name="bargein" value="true"/>
		<field name="collect" type="digits">
			<property name="maxdigit" value="3"/>
			<prompt timeout="10"> 
				<audio expr="getFullAudio('DefaultPlay.wav');"/>						
			</prompt>
			<filled>
			<!-- 拨号和位间收号超时 -->
				<log>您输入的是:<value expr="collect"/></log>
				<throw event="diconnectCalling"/>
			</filled>
			<!-- 多用于ASR收号 -->
			<catch event="nomatch">
				<log>没有匹配</log>
				<throw event="exit"/>
			</catch>
			<!-- 首位收号超时 -->
			<catch event="noinput">
				<log>没有输入</log>
				<if cond="countAdd()==failCount">
					<throw event="diconnectCalling"/>
				<else/>
					<clear namelist="collect"/>
				</if>
			</catch>
			<catch event="timeout">
				<log>注意超时</log>
				<throw event="exit"/>
			</catch>
		</field>
	</form>	
</vxml>