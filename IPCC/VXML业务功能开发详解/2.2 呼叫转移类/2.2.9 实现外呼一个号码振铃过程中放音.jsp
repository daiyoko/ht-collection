<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
    <property name="inputmodes" value="dtmf"/>

    <form id="main">
        <var name="curssp"/>
        <var name="sspCallOut"/>
        <var name="nCause"/>
        <var name="MyCallHook"/>
        <var name="MyCallOutwhoHook"/>
        <var name="OTAFlag"/>

	<!-- 获取当前SSP -->
        <object name="getcurssp" classid="method://huawei/Other/GetCurSSP">
	      <!-- 将当前SSP存放再curssp变量中 -->
	      <param name="SSP" expr="curssp"/>
	</object>
	
	<!-- 建立呼叫 -->
        <object name="MyCallSetup" classid="method://huawei/Call/CallSetup">
            <!-- 主叫号 -->
            <param name="CLI" expr="'7100'"/>
            <!-- 被叫号 -->
            <param name="CLD" expr="'7101'"/>
            <!-- 呼叫特征 ，0表示普通呼叫 -->
            <param name="CF" expr="0"/>
            <!-- 输出参数，返回该次呼叫的SSP -->
            <param name="SSP" expr="sspCallOut"/>
            <!-- 输出参数，返回原因码 -->
            <param name="Cause" expr="nCause"/>
            <filled>
                <if cond="MyCallSetup!='SUCCESS'">
                    <!--呼叫建立失败，直接获取拆线原因码-->
                    <if cond="nCause==255">
                        <log>主叫拆线</log>
                        <throw event="exit"/>
                    <else/>
                        
                    </if>
                <else/>
                    <!--呼叫建立成功-->
                    <clear namelist="userplaydrv"/>
                    <goto nextitem="userplaydrv" />
                </if>
            </filled>
        </object>   
         

        <!--  放音-->
      	<object name="userplaydrv" classid="method://huawei/InOutPut/VPPlayDrv" cond="false">
		 <!-- 放音的内容或对应语音编码 -->
                 <param name="MaxDigit"  value="0"/>
                 <param name="MinDigit"  value="0"/>
                 <param name="PlayType" value="0"/>
		 <param name="PlaySentence" value="20003"/>
		 <param name="PlayObjectSSP" expr="curssp"/>
		 	
		 <filled>	
		        <log>开始给用户放音</log> 
	                <if cond="'USER_HOOK'==userplaydrv">
			     <log>用户挂机</log>
                             <if cond="nCause == curssp">
	                        <log>呼出呼叫拆线</log>
	                        <assign name="OTAFlag" expr="1"/>
	                        <goto nextitem="callOutSspHook" />
	                    <else/>
	                        <log>主叫叫拆线</log>
	                        <assign name="OTAFlag" expr="0"/>
	                        <goto nextitem="curSspHook" />
	                    </if>
                        <!-- 只有当MaxDigit=0时才触发 -->
                        <elseif cond="'PLAY_END'==userplaydrv"/>
			     <log>放音结束</log>
                             <throw event="exit"/>                
                        <elseif cond="'TIME_OUT'==userplaydrv"/>
               		<!-- 首位收号超时 -->
			     <log>超时</log>
                             <throw event="exit"/>                 
                        <elseif cond="'ERROR'==userplaydrv"/>
 			     <log>出错</log>
                             <throw event="exit"/>     
                        <!-- 只在参数OutputInfo 缺省时才有该返回值 -->            
                        <elseif cond="'SUCCESS'==userplaydrv"/>
                	     <log>放音成功出口</log>
                             <clear namelist="MyMsgProc"/>
                             <goto nextitem="MyMsgProc" />
                        <else/>
                              <log>摘机出口</log>
                             <clear namelist="connectcall"/>                   	
                        </if>
                 </filled>
	</object>
	
	<!-- 事件处理 -->
        <object name="MyMsgProc" classid="method://huawei/Other/ProcessEvent" cond="false">
            <param name="OutputInfo" expr="nCause"/>
            <filled>
                
                <log>等待摘机/挂机/检测结果</log>
                <if cond="MyMsgProc=='USER_HOOK_OFF'">
                    <log>呼出呼叫摘机</log>
                    <goto nextitem="connectcall" />
                <elseif cond="MyMsgProc=='USER_HOOK'"/>
                    <if cond="nCause == sspCallOut">
                        <log>呼出呼叫拆线</log>
                        <assign name="OTAFlag" expr="1"/>
                        <goto nextitem="callOutSspHook" />
                    <else/>
                        <log>主叫叫拆线</log>
                        <assign name="OTAFlag" expr="0"/>
                        <goto nextitem="curSspHook" />
                    </if>
                <else/>
                	<log>其他原因</log>
                	<assign name="MyCallHook" expr="0"/>
                        <assign name="MyCallOutwhoHook" expr="0"/>
                	<clear namelist="MyCallOutRel"/>
                </if>
            </filled>
        </object>

        <object name="connectcall" classid="method://huawei/Resource/ConnectCall" cond="false">
		<param name="SspSrc" expr="curssp"/><!--源SSP-->
		<param name="SspDes" expr="sspCallOut"/><!--目的SSP -->
		<param name="ConnectType" value="2"/>
		<filled>
			<log>等待资源连接成功</log>
			<goto nextitem="stoppalaydrv" />
		</filled>
 	</object>
 	
        
	<!-- 0主叫挂机 -->
	<block name="curSspHook" cond="OTAFlag=='0'">
		<assign name="MyCallHook" expr="4"/>
                <assign name="MyCallOutwhoHook" expr="0"/>
		<goto nextitem="MyCallOutRel"/>
	</block>
	
	<!-- 1被叫挂机 -->
	<block name="callOutSspHook" cond="OTAFlag=='1'">
		<assign name="MyCallHook" expr="0"/>
                <assign name="MyCallOutwhoHook" expr="4"/>
		<goto nextitem="MyCallRel"/>
	</block>
			
	<!-- 主动释放呼出呼叫 -->
        <object name="MyCallOutRel" classid="method://huawei/Call/Disconnect" cond="false">
            <param name="Cause" expr="MyCallOutwhoHook"/>
            <param name="SSP" expr="sspCallOut"/>
            <filled>
                <log><value expr="MyCallOutRel"/></log>
                <exit/>
            </filled>
        </object>
        
        <!-- 主动释放当前呼叫 -->
        <object name="MyCallRel" classid="method://huawei/Call/Disconnect" cond="false">
            <param name="Cause" expr="MyCallHook"/>
            <param name="SSP" expr="curssp"/>
            <filled>
                <log><value expr="MyCallRel"/></log>
                <exit/>
            </filled>
        </object>
        
	
	<object name="stoppalaydrv" classid="method://huawei/InOutPut/StopPlayDrv" cond="false">
		<param name="VoiceResource" value="1"/>
		<param name="StopMode" value="0"/>
		
		<filled>
                    <log>停止放音</log>
                    <goto nextitem="connectMyMsgProc" />
                </filled>
	</object>
	<!-- 事件处理 -->
        <object name="connectMyMsgProc" classid="method://huawei/Other/ProcessEvent" cond="false">
            <param name="OutputInfo" expr="nCause"/>
            <filled>                
                <log>开始通话<value expr="connectMyMsgProc"/></log>
                <if cond="MyMsgProc=='USER_HOOK'">             
                    <if cond="nCause == sspCallOut">
                        <log>呼出呼叫拆线</log>
                        <assign name="OTAFlag" expr="1"/>
                        <goto nextitem="callOutSspHook" />
                    <else/>
                        <log>主叫叫拆线</log>
                        <assign name="OTAFlag" expr="0"/>
                        <goto nextitem="curSspHook" />
                    </if>
                </if>
            </filled>
        </object>
    </form>
</vxml>
