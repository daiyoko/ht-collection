<?xml version="1.0" encoding="GB2312"?>
<vxml version="2.0">
	<%	
	Thread.sleep(10000);
	%>
	<form>
		<property name="inputmodes" value="dtmf"/>
		<property name="Termchar" value="#"/>
		<var name="SSP" expr="curssp"/>
		<block>
			<object name="getcurssp" classid="method://huawei/Other/GetCurSSP" expr="true">
				<param name="SSP" expr="curssp"/>
				<filled>
					<if cond="getcurssp=='SUCCESS'">
						<exit/>
					</if>
				</filled>
			</object>
		</block>
	</form>
</vxml>
