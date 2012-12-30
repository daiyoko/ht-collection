<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
	<form id="transToAccess">
		
		<object name="TransferCallByDN" classid="method://huawei/CallExtend/TransferCallByDN">
			<param name="AccessCode" value="10086"/>
			<filled>
				<if cond="TransferCallByDN == 'SUCCESS'">
					<throw event="connection.disconnect.transfer"/>
				</if>
			</filled>
		</object>
		<subdialog name="">
		<return/>
		</subdialog>
	</form>
</vxml>
