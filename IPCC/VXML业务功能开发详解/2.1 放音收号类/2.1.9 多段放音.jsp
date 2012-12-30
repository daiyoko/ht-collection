<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
	<form id="playdrvbagein">
		<property name="inputmodes" value="dtmf"/>
		<property name="bargein" value="true"/>			
	
		<field name="collect" >
			<prompt>
				<audio src="y:\wait.wav"/>	
				<audio src="y:\wait.wav"/>					
			</prompt>
			<prompt bargein="false">
				<audio src="y:\wait.wav"/>						
			</prompt>
			<filled>
				您输入的是
				<value expr="collect"/>
			</filled>
			<catch event="nomatch">
				没有匹配
				<throw event="exit"/>
			</catch>
			<catch event="noinput">
				没有输入
				<throw event="exit"/>
			</catch>
			<catch event="timeout">
				注意超时
				<throw event="exit"/>
			</catch>
		</field>
	</form>	
</vxml>