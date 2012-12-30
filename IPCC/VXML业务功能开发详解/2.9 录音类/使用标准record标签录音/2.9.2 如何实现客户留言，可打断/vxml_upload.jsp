<?xml version="1.0" encoding="gb2312"?>
<vxml version="1.0">
    <property name="inputmodes" value="dtmf"/>
	<form>
	<var name="nCount" expr="1"/>
	<record  name="MsgContent" beep="true" maxtime="10s" finalsilence="4000ms" dtmfterm="true">         
         <filled>
            <if cond="nCount!=2">
               <clear namelist="MsgContent"/>
               <assign name="nCount" expr="nCount+1"/>
            </if>           
       </filled>
     </record>
     <catch event="telephone.disconnect.hangup">
	    <submit next="http://10.166.102.154:8080/VXML/RecvUploadRecord.jsp" namelist="MsgContent" method="post" enctype="multipart/form-data"/>
	 </catch>
     <block name="save">
        <submit next="http://10.166.102.154:8080/VXML/RecvUploadRecord.jsp" namelist="MsgContent" method="post" enctype="multipart/form-data"/>
	 </block>
	</form>
</vxml>