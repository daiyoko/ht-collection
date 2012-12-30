<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
<!-- 发送CCP数据包到IVR -->
    <form id="main">
    
	<var name="userName" expr="Object()"/>
	<var name="userpassword" expr="Object()"/>
	<var name="returnMsg" expr="Object()"/>
	<var name="msglen" expr="Object()"/>
	<var name="clearInfo" expr="Object()"/>
	<var name="param1" expr="Object()"/>
	
	<block>
		<assign name="userName.type" expr="'String'"/><!--参数类型-->
		<assign name="userName.value" expr="'1#df2#df3fsdf#1#'"/>
		<assign name="userName.size" expr="20"/>
	
		<assign name="userpassword.type" expr="'String'"/>
		<assign name="userpassword.value" expr="'1'"/>
		<assign name="userpassword.size" expr="20"/>
		
		<assign name="returnMsg.type" expr="'String'"/>
		<assign name="returnMsg.size" expr="20"/>
		
				
		<assign name="clearInfo.type" expr="'String'"/>
		<assign name="clearInfo.size" expr="50"/>
		<assign name="clearInfo.value" expr="''"/>
		
		<assign name="msglen.type" expr="'INT_2'"/>
		
		<assign name="param1.type" expr="'String'"/>
		<assign name="param1.size" expr="20"/>
		<assign name="param1.value" expr="'1#test#testtest#1#3'"/>
	</block>
	
	<var name="nPackLen" expr="0"/>
	<var name="nPackInfo" expr="0"/>
	<object name="Pack" classid="method://huawei/Other/Pack">
		<param name="PackLen" expr="nPackLen"/>
		<param name="paramname1" expr="userName"/>
		<param name="paramname2" expr="userpassword"/>
		<filled>
			<log>nPackLen:<value expr="nPackLen"/></log>
		</filled>
	</object>
	<!-- 由流程发送首发包 -->
	<object name="sendCCP" classid="method://huawei/Extend/SendProxyMsg">
		<!--是否首发包  0表示后续包，1表示首发包-->
		<param name="FirstSendFlag" expr="1"/>
		<!--表示远端通讯代理的配置中配置的对端网络号，当发送首发包时，必须填写-->
		<param name="NetNumber" expr="1"/>	
		<!--表示远端通讯代理中配置的对端网络的IVR 或客户端的服务端序号，当发送首发包时，必须填写-->
		<param name="RemoteIndex" expr="2"/>
		<!--对端句柄。当发送首发包时，不必填写。
			当发送后继包（非首发包）时，需要填写对端句柄变量。
			一般是在使用等待请求<object>后由系统自动赋值给流程填写的对端句柄变量  -->
		<param name="RemoteDsn" value="0"/>	
		<!-- 表示需要发送的消息包的长度 -->
		<param name="MsgLen" expr="nPackLen"/>
		
		<!-- 
		一般填写使用数据包object 打包数据时表示数据包的那个变量。
		如果该参数缺省，表示使用系统参数呼叫附加信息。
		跟打包对应。
		<param name="MsgInfo" value="MsgInfo"/>
		 -->
		 <filled>
		 	<if cond="sendCCP=='FAILURE'">
		 		<exit/>
		 	<else/>
		 		<clear namelist="Pack2 waitproxymsg"/>
		 		<log>发送CCP消息成功</log>
		 	</if>
		 </filled>
	</object>
	
	<!-- 清空呼叫附加信息 -->
	<object name="Pack2" classid="method://huawei/Other/Pack" expr="true">
		<param name="PackLen" expr="nPackLen"/>
		<param name="paramname1" expr="clearInfo"/>
	</object>

	<var name="RemoteDsn1" expr="Object()"/>
	<var name="nMsgLen" expr="30"/>
	<object name="waitproxymsg" classid="method://huawei/Extend/WaitProxyMsg" expr="true">
		<param name="RemoteDsn" value="RemoteDsn1"/>
		<param name="TimeOut" value="6"/>
		<param name="MsgLen" expr="nMsgLen"/>
		<filled>
			<if cond="waitproxymsg=='SUCCESS'">
				<log>接收CCP回复消息成功 </log>
				<log>
					<value expr="RemoteDsn1.net"/>
			        <value expr="RemoteDsn1.id"/>
			        <value expr="RemoteDsn1.flag"/>
			        <value expr="RemoteDsn1.handle"/>
			        <value expr="RemoteDsn1.dsn"/>
			        <value expr="RemoteDsn1.reserved"/>
				</log>
				<clear namelist="Unpack"/>
			<else/>
				<clear namelist="waitproxymsg"/>
			</if>
		</filled>
	</object>
		
	<!--解包-->
	<object name="Unpack" classid="method://huawei/Other/Unpack" expr="true">
		<param name="PackLen" expr="20"/>
		<!-- 重要，参数长度，文档中没提及 -->
		<param name="parammsglen" expr="msglen"/>
		<param name="paramname1" expr="returnMsg"/>
		<filled>
			<if cond="Unpack=='SUCCESS'">
				<log>returnMsg：<value expr="returnMsg.value"/></log>
				<clear namelist="Pack3 sendcontinuemsg"/>
			<else/>
				<exit/>
			</if>
		</filled>
	</object>

	<!-- 打包后续包发送数据 -->
	<object name="Pack3" classid="method://huawei/Other/Pack" expr="true">
		<param name="PackLen" expr="nPackLen"/>
		<param name="paramname1" expr="param1"/>
	</object>
	
	<!-- 发送CCP 后续包 -->
	<object name="sendcontinuemsg" classid="method://huawei/Extend/SendProxyMsg" expr="true">
		<param name="FirstSendFlag" value="0"/>
		<param name="RemoteDsn" value="RemoteDsn1"/>
		<param name="MsgLen" expr="nMsgLen"/>
		<filled>
			<if cond="sendcontinuemsg=='SUCCESS'">
				<log>后续包发送成功</log>
			</if>
		</filled>
	</object>
    </form>
</vxml>
