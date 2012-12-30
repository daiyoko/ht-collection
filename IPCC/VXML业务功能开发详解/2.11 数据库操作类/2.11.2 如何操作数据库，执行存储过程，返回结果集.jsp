<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">


<!-- 测试过程中发现问题，结果集里最后一条记录的age值一直为0 -->

    <form id="main">
    	<!-- varReocrdProcID必须为-1 -->
	    <var name="varReocrdProcID" expr="-1"/>
		<!--object 变量定义-->
		<var name="in_age" expr="Object()"/>
		<var name="username" expr="Object()"/>
		<var name="password" expr="Object()"/>
		<var name="age" expr="Object()"/>

	<block>
		<!--object 变量赋值-->
		<assign name="in_age.type" expr="'INT_1'"/>
		<assign name="in_age.value" expr="30"/>
		<assign name="in_age.inout" expr="0"/>
		
		<assign name="username.type" expr="'String'"/>
		<assign name="username.size" expr="20"/>
		<assign name="username.inout" expr="3"/>
		<assign name="password.type" expr="'String'"/>
		<assign name="password.size" expr="20"/>
		<assign name="password.inout" expr="3"/>
		<assign name="age.type" expr="'INT_1'"/>
		<assign name="age.inout" expr="3"/>
	</block>
	<object name="ReadRecord" classid="method://huawei/Db/ExDBStroeProc">
		<param name="ProcName" expr="'queryinfo'"/>
		<param name="DataSource" expr="'ivrdb'"/>
		<param name="Delay" expr="5"/>
		<param name="ExProcID" expr="varReocrdProcID"/>
		<!--存储过程参数-->
		<param name="paramname1" expr="in_age"/> 
		<!--存储过程结果集变量-->
		<param name="paramname2" expr="username"/> 
		<param name="paramname3" expr="password"/> 
		<param name="paramname4" expr="age"/> 
		<filled>
			<if cond="'FAILURE'==ReadRecord">
				<assign name="varTimerID" expr="70"/>
				<assign name="varTimeOut" expr="2"/>
				<clear namelist="SetTimer"/>
			<elseif cond="'NULL_RECORD'==ReadRecord"/>
				<throw event="exit"/>
			<else/>
				<log>username:<value expr="username.value"/></log>
				<log>password:<value expr="password.value"/></log>
				<log>age:<value expr="age.value"/></log>
				<!-- 下一条记录 -->
				<clear namelist="ReadRecord"/> 
			</if>
		</filled>
	</object>
    </form>
</vxml>
