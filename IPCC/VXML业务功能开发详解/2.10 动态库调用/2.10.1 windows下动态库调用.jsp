<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
    <form id="main">
    	<var name="str1" />
    	<var name="str2" />
    	<var name="strResult"/>
    	<var name="num1" />
    	<var name="num2" />
    	<var name="sumnum"/>
    	<var name="resultCode"/>
    	<var name="libName"/>
    	<var name="functionName"/>
    	<block>
	    	<assign name="str1" expr="'ab'"/>
	    	<assign name="str2" expr="'cd'"/>
	    	<assign name="num1" expr="1"/>
	    	<assign name="num2" expr="2"/>
	    	<assign name="libName" expr="'Dll.dll'"/>
	    	<assign name="functionName" expr="'Add'"/>
    	</block>
 		<object name="myUseDll" classid="method://huawei/Extend/UseDll">
			<param name="LibName" expr="libName"/>
			<param name="FunctionName" expr="functionName"/>
			<param name="Param1" expr="str1" type="string:in"/>
			<param name="Param2" expr="str2" type="string:in"/>
			<param name="Param3" expr="strResult" type="string:out"/>
			<param name="Param4" expr="num1" type="int:in"/>
			<param name="Param5" expr="num2" type="int:in"/>
			<param name="Param6" expr="sumnum" type="int:out"/>
			<param name="ResultCode" expr="resultCode"/>
			<filled>
				<if cond="myUseDll=='SUCCESS'">
					<log>调用动态链接库成功</log>
					<log>strResult:<value expr="strResult"/></log>
					<log>sumnum:<value expr="sumnum"/></log>
				<else/>
					<log><value expr="resultCode"/></log>
				</if>
			</filled>
		</object>
    </form>
</vxml>
