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
		
		<!-- 操作呼叫IE 扩展数据 -->
        <object name="MySetIE" classid="method://huawei/CallExtend/operateieinfo">
        	<!-- 操作方式，0表示去呼叫信息，1表示设置呼叫信息 -->
            <param name="OperateType" expr="0"/>
            <!-- 消息类型 1：setup 3：alert 4：notify 5：answer 7：offhook 8: Disconnect 32：redirct -->
            <param name="MsgType" expr="1"/>
            <!-- IE的名称，135表示检测被叫状态 -->
            <param name="IeName" expr="135"/>
            <!-- 信息名字ID -->
            <param name="InfoName" expr="0"/>
            <!-- IE 信息值 -->
            <param name="InfoValue" expr="1"/>
            <filled>
                <clear namelist="MyCallSetup"/>
            </filled>
        </object>

		<!-- 建立呼叫 -->
        <object name="MyCallSetup" classid="method://huawei/Call/CallSetup" expr="true">
            <!-- 主叫号 -->
            <param name="CLI" expr="'6669001'"/>
            <!-- 被叫号 -->
            <param name="CLD" expr="'7102'"/>
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
                        <clear namelist="MyCheckRel"/>
                    <else/>
                        <log>主叫叫拆线</log>
                    </if>
                <elseif cond="MyMsgProc=='RECEIVE_DETECT_RES'"/>
                    <if cond="nCause==1"><!-- 用户空闲 -->
                        <clear namelist="MyMsgProc"/><!-- 继续等待被叫摘机 -->
                    <elseif cond="nCause==2"/><!-- 用户忙 -->
                        
                    <elseif cond="nCause==3"/> <!-- NO_RESOURCE -->
                       
                    <elseif cond="nCause==4"/><!-- CALL_DIVERSION -->
                        
                    <elseif cond="nCause==5"/><!-- CALL_WAITING -->
                        
                    <elseif cond="nCause==6"/><!-- DEFLECTION_BUSY -->
                        
                    <elseif cond="nCause==7"/><!-- DEFLECTION_NO_RESPOND -->
                        
                    <elseif cond="nCause==8"/><!-- DEFLECTION_UNCONDICTION -->
                        
                    <elseif cond="nCause==9"/><!-- DET_CALL_SUPER_DONT_DISTURB -->
                        
                    <elseif cond="nCause==10"/> <!-- DET_CALL_DEFLECTION -->
                       
                    <elseif cond="nCause==11"/><!-- DET_DEFLECTION_IMMEDIATE_RESPONSE -->
                        
                    <elseif cond="nCause==12"/> <!-- DET_MOBILE_SUBSCRIBER_NOT_REACHABLE -->
                       
                    <elseif cond="nCause==13"/><!-- DET_CALLED_DTE_OUT_OF_ORDER -->
                        
                    <elseif cond="nCause==14"/><!-- DET_CALL_FORWARDING_BY_THE_CALLED_DTE -->
                        
                    <elseif cond="nCause==15"/><!-- DET_CALLED_CT -->
                        
                    <elseif cond="nCause==16"/><!-- DET_RESERVE1 -->
                        
                    <elseif cond="nCause==17"/> <!-- DET_RESERVE2 -->
                      
                    <elseif cond="nCause==18"/><!-- DET_ANNOUNCE_SIG -->
                        
                    <elseif cond="nCause==129"/> <!-- UNALLOC_CODE -->
                       
                    <elseif cond="nCause==132"/><!-- SEND_PRIVATE_TONE -->
                        
                    <elseif cond="nCause==145"/><!-- 用户忙 -->
                        
                    <elseif cond="nCause==146"/> <!-- 用户未响应 -->
                       
                    <elseif cond="nCause==147"/> <!-- 用户未应答 -->
                       
                    <elseif cond="nCause==149"/><!-- 呼叫拒收-->
                        
                    <elseif cond="nCause==150"/><!-- 号码改变 -->
                        
                    <elseif cond="nCause==155"/> <!-- 目的地不可达 -->
                       
                    <elseif cond="nCause==160"/><!-- INTESS_OC_MD_MUSIC -->
                        
                    <elseif cond="nCause==161"/>
                        <!-- INTESS_OC_AMD_HUMAN -->
                    <elseif cond="nCause==162"/>
                        <!-- INTESS_OC_AMD_MACHINE -->
                    <elseif cond="nCause==180"/>
                        <!-- INTESS_OC_TD_RINGBACK -->
                    <elseif cond="nCause==181"/>
                        <!-- INTESS_OC_TD_BUSY -->
                    <elseif cond="nCause==182"/>
                        <!-- INTESS_OC_TD_SIT -->
                    <elseif cond="nCause==184"/>
                        <!-- INTESS_OC_TD_MODEM -->
                    <elseif cond="nCause==185"/>
                        <!-- INTESS_OC_TD_FAX -->
                    <elseif cond="nCause==186"/>
                        <!-- INTESS_OC_TD_MODEMORFAX -->
                    <elseif cond="nCause==187"/>
                        <!-- INTESS_OC_TD_TONE_UNDEFINE -->
                    <elseif cond="nCause==190"/>
                        <!-- INTESS_OC_TD_TP_ANS1 -->
                    <elseif cond="nCause==191"/>
                        <!-- INTESS_OC_TD_TP_ANS2 -->
                    <elseif cond="nCause==192"/>
                        <!-- INTESS_OC_TD_TP_ANS3 -->
                    <elseif cond="nCause==193"/>
                        <!-- INTESS_OC_TD_TP_ANS4 -->
                    <elseif cond="nCause==194"/>
                        <!-- INTESS_OC_TD_TP_ANS5 -->
                    <elseif cond="nCause==195"/>
                        <!-- INTESS_OC_TD_TP_EDT -->
                    <elseif cond="nCause==196"/>
                        <!-- INTESS_OC_TD_TP_FSK -->
                    <elseif cond="nCause==197"/>
                        <!-- INTESS_OC_TD_TP_DTMF -->
                    <elseif cond="nCause==253"/><!-- 不知道的回铃音 -->
                        <clear namelist="MyMsgProc"/><!-- 继续等待被叫摘机 -->
                    <elseif cond="nCause==254"/><!-- 在信号音检测过程时，接收到用户的应答消息 -->
                        <clear namelist="MyMsgProc"/><!-- 继续等待被叫摘机 -->
                    <elseif cond="nCause==255"/>
                        <!-- BUTT_TONE -->
                    <else/>
                        <!-- unknown -->
                    </if> 
                    <!-- impossible -->
                </if>
            </filled>
        </object>


		<!-- 获取拆线原因 -->
        <object name="MyCheckRel" classid="method://huawei/Call/GetDisconnectCause" expr="true">
            <param name="Cause" expr="nCause"/>
            <filled>
                <log>呼出呼叫拆线, 需要检查拆线原因</log>
                 <log>拆线原因码：<value expr="nCause"/></log>
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
		
		<!-- 主动释放呼叫 -->
        <object name="MyCallOutRel" classid="method://huawei/Call/Disconnect" expr="true">
            <param name="Cause" expr="0"/>
            <param name="SSP" expr="sspCallOut"/>
            <filled>
                <log><value expr="MyCallOutRel"/></log>
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
