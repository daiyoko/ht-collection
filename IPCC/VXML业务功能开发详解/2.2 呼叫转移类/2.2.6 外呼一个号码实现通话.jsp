<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
    <property name="inputmodes" value="dtmf"/>

    <form id="main">
        <var name="curssp"/>
        <var name="sspCallOut"/>
        <var name="nCause"/>

		<!-- 获取当前SSP -->
        <object name="getcurssp" classid="method://huawei/Other/GetCurSSP">
			<!-- 将当前SSP存放再curssp变量中 -->
			<param name="SSP" expr="curssp"/>
		</object>
		
		<!-- 建立呼叫 -->
        <object name="MyCallSetup" classid="method://huawei/Call/CallSetup">
            <!-- 主叫号 -->
            <param name="CLI" expr="'6669001'"/>
            <!-- 被叫号 -->
            <param name="CLD" expr="'010086'"/>
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
                        <clear namelist="MyCheckRel"/>
                    </if>
                <else/>
                    <!--呼叫建立成功-->
                    <clear namelist="MyMsgProc"/>
                </if>
            </filled>
        </object>   
         

		<!-- 事件处理 -->
        <object name="MyMsgProc" classid="method://huawei/Other/ProcessEvent" expr="true">
            <param name="OutputInfo" expr="nCause"/>
            <filled>
                
                <log>等待摘机/挂机/检测结果</log>
                <if cond="MyMsgProc=='USER_HOOK_OFF'">
                    <log>呼出呼叫摘机，进行combine</log>
                    <clear namelist="combine MyMsgProc2"/>
                <elseif cond="MyMsgProc=='USER_HOOK'"/>
                    <if cond="nCause == sspCallOut">
                        <log>呼出呼叫拆线</log>
                        <clear namelist="MyCallOutRel MyCallRel"/>
                    <else/>
                        <log>主叫叫拆线</log>
                        <clear namelist="MyCallOutRel MyCallRel"/>
                    </if>
                <else/>
                	<log>其他原因</log>
                	<clear namelist="MyCallOutRel MyCallRel"/>
                </if>
            </filled>
        </object>


		<!-- 获取拆线原因 -->
        <object name="MyCheckRel" classid="method://huawei/Call/GetDisconnectCause" expr="true">
            <param name="Cause" expr="nCause"/>
            <filled>
                <log>呼出呼叫拆线, 需要检查拆线原因</log>
                <if cond="nCause==0"><!--呼叫正常拆除-->
                 
                <elseif cond="nCause==1"/> <!--资源已占满-->
                   
                <elseif cond="nCause==2"/><!--超时-->
                    
                <elseif cond="nCause==3"/><!--呼出失败-->
                    
                <elseif cond="nCause==4"/><!--空号-->                    
            
                <elseif cond="nCause==8"/><!--用户无应答-->
                    
                <elseif cond="nCause==9"/><!--用户拒绝-->
                    
                <elseif cond="nCause==10"/><!--SP_Call_Absent-->
                    
                <elseif cond="nCause==47"/><!--用户忙-->
                    
                <elseif cond="nCause==48"/>
                    <!--SP_CpConf_Fault-->
                <elseif cond="nCause==49"/>
                    <!--SP_Intess_Error-->
                <elseif cond="nCause==50"/>
                    <!--SP_NO_OUT_BOUND_CALL_DETECT_RESOURCE-->
                <else/>
                    <!-- unknown cause -->
                </if>
            </filled>
        </object>
		
		<!-- 主动释放呼出呼叫 -->
        <object name="MyCallOutRel" classid="method://huawei/Call/Disconnect" expr="true">
            <param name="Cause" expr="0"/>
            <param name="SSP" expr="sspCallOut"/>
            <filled>
                <log><value expr="MyCallOutRel"/></log>
            </filled>
        </object>
        
        <!-- 主动释放当前呼叫 -->
        <object name="MyCallRel" classid="method://huawei/Call/Disconnect" expr="true">
            <param name="Cause" expr="0"/>
            <param name="SSP" expr="curssp"/>
            <filled>
                <log><value expr="MyCallRel"/></log>
            </filled>
        </object>
        
        <object name="combine" classid="method://huawei/Resource/ConnectCall" expr="true">
        	<param name="SspSrc" expr="curssp"/>
        	<param name="SspDes" expr="sspCallOut"/>
        	<param name="ConnectType" expr="2"/>
        </object>
        
         <object name="MyMsgProc2" classid="method://huawei/Other/ProcessEvent" expr="true">
            <param name="OutputInfo" expr="nCause"/>
            <filled>
                <if cond="MyMsgProc=='USER_HOOK'">
                	<exit/>
				</if>
            </filled>
        </object>
        <!-- 呼叫跳接，将SSP1和SSP2两个呼叫连接
        <object name="combine" classid="method://huawei/Call/Combine" expr="true">
			<param name="SSP1" expr="sspCallOut"/>
			<param name="SSP2" expr="curssp"/>
		</object>
		 -->
    </form>
</vxml>
