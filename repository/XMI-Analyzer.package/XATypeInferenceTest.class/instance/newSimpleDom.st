instance creation
newSimpleDom
	<script: 'self new newSimpleDom inspect'>
	^ XMLDOMParser
		parse:
			'<xmi:XMI xmi:version="2.1" xmlns:xmi="http://schema.omg.org/spec/XMI/2.1">
	<container xmi:id="ID_C_1" name="Container">
		<node xmi:id="ID_N_1" name="First Node" property="false">
			<outgoing xmi:idref="ID_E_1"/>
		</node>
		<node xmi:id="ID_N_2" name="First Node" property="true">
			<incoming xmi:idref="ID_E_1"/>
			<outgoing xmi:idref="ID_E_2"/>
		</node>
		<node xmi:id="ID_N_3" name="First Node" size="10">
			<incoming xmi:idref="ID_E_1"/>
			<incoming xmi:idref="ID_E_2"/>
		</node>
		<edge xmi:id="ID_E_1" source="ID_N_1" target="ID_N_2 ID_N_3"/>
		<edge xmi:id="ID_E_2" source="ID_N_2" target="ID_N_3"/>
	</container>
</xmi:XMI>'