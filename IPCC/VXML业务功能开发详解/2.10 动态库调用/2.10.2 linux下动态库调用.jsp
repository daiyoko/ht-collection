<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
    <form id="main">
    <!-- 将动态库拷贝到$ICDDIR/lib目录下，并且授权777 -->
    	<var name="num1" />
    	<var name="num2" />
    	<var name="sumnum"/>
    	<var name="resultCode"/>
    	<var name="libName"/>
    	<var name="functionName"/>
    	<block>
	    	<assign name="num1" expr="'1'"/>
	    	<assign name="num2" expr="'2'"/>
	    	<assign name="libName" expr="'Add.so'"/>
	    	<assign name="functionName" expr="'Add'"/>
    	</block>
 		<object name="myUseDll" classid="method://huawei/Extend/UseDll">
			<param name="LibName" expr="libName"/>
			<param name="FunctionName" expr="functionName"/>
			<param name="Param1" expr="num1" type="int:in"/>
			<param name="Param2" expr="num2" type="int:in"/>
			<param name="Param3" expr="sumnum" type="int:out"/>
			<param name="ResultCode" expr="resultCode"/>
			<filled>
				<if cond="myUseDll=='SUCCESS'">
					<log>调用动态链接库成功 <value expr="resultCode"/></log>
					<log>sumnum:<value expr="sumnum"/></log>
				<else/>
					<log><value expr="resultCode"/></log>
				</if>
			</filled>
		</object>
    </form>
</vxml>
