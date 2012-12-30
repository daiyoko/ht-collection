<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
	<form id="subIvr">
	
	<var name="param" expr="Object()"/>
	<block>
		<assign name="param.type" expr="'String'"/>
		<assign name="param.size" expr="4"/>
	</block> 
	<var name="nPackLen" expr="0"/>
		<!--解包-->
	<object name="Unpack" classid="method://huawei/Other/Unpack">
		<param name="PackLen" expr="nPackLen"/>
		<param name="paramname" expr="param"/>
	</object>
	
	<block>
		<log>传递的数据是:<value expr="param.value"/></log>
	</block>

	</form>
</vxml>
