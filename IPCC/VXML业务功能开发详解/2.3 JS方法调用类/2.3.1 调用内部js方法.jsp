<?xml version="1.0" encoding="GB2312"?>
<vxml version="1.0">
<script>
	function strAdd(a,b){
		return a+b;
	}
	function intAdd(a,b){
		return parseInt(a)+parseInt(b);
	}

</script>


	<form>
		<block>
			<var name="a" expr="'1'"/>
			<var name="b" expr="'2'"/>
			<var name="c" />
			<script>
				c = 3;
			</script>
			<assign name="sumNum" expr="intAdd(a,b)"/>
			<assign name="sumStr" expr="strAdd(a,c)"/>
			<log>a为:<value expr="a"/></log>
			<log>b为:<value expr="b"/></log>
			<log>c为:<value expr="c"/></log>
			<log>数字和为:<value expr="sumNum"/></log>
			<log>字符串和为:<value expr="sumStr"/></log>
		</block>
	</form>
</vxml>
