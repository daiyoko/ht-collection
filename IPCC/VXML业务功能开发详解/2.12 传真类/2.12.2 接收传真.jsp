<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
    <form id="main">
		<object name="faxreceive" classid="method://huawei/Fax/ReceiveFax">
			<param name="FileName" value="Y:\fax\myreceive1.tif"/>
			<param name="TimeOut" value="180"/>
			<filled>
				<if cond="faxreceive=='SUCCESS'">
					<log>接收成功</log>
				<elseif cond="faxreceive=='FAILURE'"/>
					<log>接收失败</log>
				<elseif cond="faxreceive=='USER_HOOK'"/>
					<log>用户挂机</log>
				<elseif cond="faxreceive=='TIME_OUT'"/>
					<log>接收超时</log>
				<elseif cond="faxreceive=='ERROR'"/>
					<log>严重错误</log>
				</if>
				<catch>
					<throw event="exit"/>
				</catch>
				
			</filled>
		</object>
    </form>
</vxml>
