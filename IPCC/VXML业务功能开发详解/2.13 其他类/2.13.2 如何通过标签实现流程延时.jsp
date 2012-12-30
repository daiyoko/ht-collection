<?xml version="1.0" encoding="GB2312"?>
<vxml version="2.0">
	<form>
		<property name="inputmodes" value="dtmf"/>
		<property name="Termchar" value="#"/>
		<object name="Sleep" classid="method://huawei/Other/Sleep">
			<param name="TimeOut" value="10"/><!--超时时间秒-->
			<filled>
				<if cond="Sleep=='USER_HOOK'">
					<throw event="telephone.disconnect"/>
				<else/>
					<clear namelist="getcurssp"/>
				</if>
				
			</filled>
		</object>
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