<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
	<form id="getDataFrmAgent">
		
		<!-- 取人工台数据 -->
		<object name="getData" classid="method://huawei/CallExtend/OperatorData">
			<!-- 操作方式,0表示取人工台数据,1表示设置人工台数据 -->
			<param name="OperateType" value="0"/>
			<!-- 表示人工台数据区中有效数据的长度。最大长度不能超过1024 个字节。 -->
			<param name="DataLen" value="100"/>
			<!-- 如果是设置人工台数据，该参数为输入参数，表示传递给人工台的数据；
				 如果是取人工台数据，该参数为输出参数，表示从人工台接收到的数据。
				 缺省表示使用系统参数呼叫附加信息。 -->
			<!--<param name="DataInfo" expr="dataInfo"/>  -->
			<filled>
				<log>获取数据<value expr="getData"/></log>
			</filled>
		</object>
		<var name="param" expr="Object()"/>
		<block >
			<assign name="param.type" expr="'String'" />
			<assign name="param.size" expr="100"/>
		</block> 
		<var name="nPackLen" expr="0"/>
		<!--解包-->
		<object name="Unpack" classid="method://huawei/Other/Unpack">
			<param name="PackLen" expr="nPackLen"/>
			<param name="paramname" expr="param"/>
		</object>
		
		<block >
			<log>人工台获取的数据是:<value expr="param.value"/></log>
		</block>
	</form>
</vxml>