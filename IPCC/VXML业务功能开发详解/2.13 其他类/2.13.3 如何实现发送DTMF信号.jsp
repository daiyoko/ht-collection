<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
	<form id="Begin_callout">
		<block>
			<assign name="application.use_conf" expr="1"/>
		</block>

		<object name="getcurssp" classid="method://huawei/Other/GetCurSSP">
			<param name="SSP" expr="application.caller_SSP"/>
				<filled>
					<log expr="'@@@@@@@@@@@@@@@主叫SSP ' + application.caller_SSP " />
				</filled>
		</object>

		<var name="curConfNo"/>
		<!--创建会场-->
		<object name="createconf" classid="method://huawei/Conf/CreateConf">
			<param name="ConfNO" expr="curConfNo"/>
            <param name="ChannelNum" expr="2"/>
            <param name="ConfType" expr="1"/>
		</object>

		<var name="callee_SSP"/>
		<!--外呼-->
		<object name="callout" classid="method://huawei/Call/CallOut">
			<param name="CLI" expr="'112'"/>
			<param name="CLD" expr="'2010001'"/>
			<param name="SSP" expr="callee_SSP"/>

			<filled>				
				<if cond="callout=='HOOK_OFF'">
					<log expr="'hook off and go on ' + callee_SSP" />
				<else/>
					<log expr="'not hook off and return'"/>
					<goto next="#release_back"/>					
				</if>
			</filled>
		</object>
		
		<var name="channel1"/>
		<!--用户加入会场-->
		<object name="joinconf" classid=" method://huawei/Conf/ConfAddUser">
			<param name="ConfNO" expr="curConfNo"/>
			<param name="SrcSSP" expr="application.caller_SSP"/>
			<param name="ConnPartyType" value="0"/>
			<param name="ConnMode" value="3"/>
			<param name="ChannelNO" expr="channel1"/>
		</object>


		<!--用户加入会场-->
		<object name="joinconf2" classid=" method://huawei/Conf/ConfAddUser">
			<param name="ConfNO" expr="curConfNo"/>
			<param name="SrcSSP" expr="callee_SSP"/>
			<param name="ConnPartyType" value="0"/>
			<param name="ConnMode" value="3"/>
			<param name="ChannelNO" expr="application.callee_ChannelNO2"/>
		</object>

		<!--启动会场录音-->
		<object name="startconfrecord" classid="method://huawei/Conf/ConfRecord">
			<param name="ConfNO" expr="curConfNo"/>
			<param name="RecordFormat" value ="2"/>
			<param name="RecordType" value ="1"/>
			<param name="RecordMode" value="0"/>
			<param name="MaxTime" value="0"/>
			<param name="FileName" expr="application.record_FileName"/>
			<param name="RecordBack" value="1"/>
		</object>
		

        <object name="CollectCallee" classid="method://huawei/Conf/CollectDigit" >
            <param name="ConfNO"   expr="curConfNo"/>
            <param name="ChannelNO" expr="channel1"/>
            <filled>
                <if cond="CollectCallee == 'SUCCESS'">
                    <clear namelist="ProcessCollect"/>
                </if>
            </filled>
        </object>    
        
       <var name="outputinfo"/>
       <object name="ProcessCollect" classid="method://huawei/Other/ProcessEvent" expr="true">
            <param name="OutputInfo"    expr="outputinfo"/>
            <filled>
            	<if cond="ProcessCollect=='CP_USERDIALING'">
            		 <if cond ="outputinfo=='1'">
            		 	<clear namelist="dtmfdigit"/>
            		 </if>
            	</if>
            </filled>
       </object>
        
        <object name="dtmfdigit" classid="method://huawei/ InOutPut/DigitDtmf" expr="true">
			<param name="SSP" expr="callee_SSP"/>
			<param name="Dtmf" expr="outputinfo"/>
		</object>

		<object name="ProcessRBT" classid="method://huawei/Other/ProcessEvent" >
			<param name="OutputInfo" expr="outputinfo"/>
			<param name="UserDialing" value="0"/>
     
			<filled>
				<if cond="ProcessRBT=='USER_HOOK'">
					<!--用户挂机-->
					<goto next="#check_hangup"/>
				<else/>
					<clear namelist="ProcessRBT"/>
				</if>
			</filled>
		</object>
	</form>


		
	
</vxml>