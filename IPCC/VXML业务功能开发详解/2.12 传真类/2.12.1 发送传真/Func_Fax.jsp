<?xml version="1.0" encoding="gb2312"?>
<vxml version="1.0">

<form id="form_SendFax">
    <var name="i_SndFaxFileName"/>    
    	<var name="ret_result"/>
        <object name="fetchFax" classid="method://huawei/Fax/SendSingleFax">
		        <param name="FileName"   expr="i_SndFaxFileName"/> 
            	<param name="TimeOut"    value="300"/>
		        <filled>
		            <if cond="fetchFax == 'SUCCESS'">           
		                <assign name="ret_result" expr="0"/>
		            <elseif cond="fetchFax == 'USER_HOOK'"/>                        
                    <assign name="ret_result" expr="1"/>
                 <else/>
                 		<assign name="ret_result" expr="1"/>
                </if>
               	<return namelist="ret_result"/>
        		</filled>        

        </object>
</form>

</vxml>