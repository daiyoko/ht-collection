<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
	<form>
		<property name="inputmodes" value="dtmf"/>
		<property name="bargein" value="true"/>	
		<!-- 放音内容为参数时，如果参数中带有盘符，则必须使用y:/1.wav 而 不能使用y:\1.wav (获取为乱码)。 -->
		<var name="para"/>
		<block>
			<!--应该使用y:/1.wav,如果不带盘符则不会有问题-->
			<assign name="para" expr="'y:/1.wav'"/>
			<value expr="para"/>
		</block>
	</form>
</vxml>