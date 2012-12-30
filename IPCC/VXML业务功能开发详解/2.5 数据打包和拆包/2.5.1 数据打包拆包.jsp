<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
	
	<form id="packData">
		<!--打包解包前准备-->
		<!--把参数1 和参数2 通过打包解包的方式传递到参数3 和参数4 中-->
		<var name="param1" expr="Object()"/>
		<var name="param2" expr="Object()"/>
		<var name="param3" expr="Object()"/>
		<var name="param4" expr="Object()"/>
		<block>
		<assign name="param1.type" expr="'INT_2'"/>
		<assign name="param1.value" expr="12"/>
		<assign name="param2.type" expr="'String'"/>
		<assign name="param2.value" expr="'abcde'"/>
		<assign name="param2.size" expr="5"/>
		<assign name="param3.type" expr="'INT_2'"/>
		<assign name="param4.type" expr="'String'"/>
		<assign name="param4.size" expr="5"/>
		<assign name="param4.size" expr="5"/>
		</block>
		<!--打包-->
		<var name="nPackLen" expr="0"/>
		<var name="nPackInfo" expr="0"/>
		<object name="Pack" classid="method://huawei/Other/Pack">
		<param name="PackLen" expr="nPackLen"/>
		<param name="paramname1" expr="param1"/>
		<param name="paramname2" expr="param2"/></object>
		<!--解包-->
		<object name="Unpack" classid="method://huawei/Other/Unpack">
		<param name="PackLen" expr="nPackLen"/>
		<param name="paramname1" expr="param3"/>
		<param name="paramname2" expr="param4"/>
		</object>
		<block>
		<log>参数1<value expr="param1.value"/></log>
		<log>参数2<value expr="param2.value"/></log>
		<log>参数3<value expr="param3.value"/></log>
		<log>参数4<value expr="param4.value"/></log>
		<log>PackLen<value expr="nPackLen"/></log>
		</block>
	</form>
</vxml>
