<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
	<form>
		<property name="inputmodes" value="dtmf"/>
		<property name="bargein" value="false"/>	
		<block>
			<prompt>
				<audio src="y:\wait.wav"/>
			</prompt>
		</block>
		<!--停止放音-->
		<object name="pauseplay" classid="method://huawei/InOutPut/VPOperate">
			<param name="Command" expr="1"/>
			<filled>
				<if cond="pauseplay == 'SUCCESS'">
					<clear namelist="continueplay"/>
					<else/>
					<exit/>
				</if>
			</filled>
		</object>
		<object name="continueplay" classid="method://huawei/InOutPut/VPOperate" expr="true">
			<param name="Command" expr="2"/>
			<filled>
				<if cond="continueplay == 'SUCCESS'">
					<clear namelist="speedup"/>
					<else/>
					<exit/>
				</if>
			</filled>
		</object>
		<object name="speedup" classid="method://huawei/InOutPut/VPOperate" expr="true">
			<param name="Command" expr="3"/>
			<param name="ControlValue" expr="3"/>
			<filled>
				<if cond="speedup == 'SUCCESS'">
					<clear namelist="speeddown"/>
					<else/>
					<exit/>
				</if>
			</filled>
		</object>
		<object name="speeddown" classid="method://huawei/InOutPut/VPOperate" expr="true">
			<param name="Command" expr="4"/>
			<param name="ControlValue" expr="6"/>
			<filled>
				<if cond="speeddown == 'SUCCESS'">
					<exit/>
				</if>
			</filled>
		</object>
	</form>
</vxml>
