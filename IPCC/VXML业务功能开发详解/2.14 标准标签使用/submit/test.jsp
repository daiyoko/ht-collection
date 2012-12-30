<%
    String  sLogHeader = (String)request.getParameter("logheader");
    System.out.println("sLogHeader="+sLogHeader);     
 %>

<?xml version="1.0" encoding="gb2312"?>
<vxml version="1.0">
  <form id="test">           
      <block name="ReturnBack">
   		<value expr="'<%=sLogHeader%>'"/>
        <exit/>
      </block>
   </form>
</vxml>