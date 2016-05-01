instance creation
newStructureDom
	<script: 'self new newStructureDom inspect'>
	^ XMLDOMParser parse: '<xmi:XMI xmi:version="2.1" xmlns:uml="http://schema.omg.org/spec/UML/2.1" xmlns:xmi="http://schema.omg.org/spec/XMI/2.1" xmlns:thecustomprofile="http://www.sparxsystems.com/profiles/thecustomprofile/1.0">
	<packagedElement xmi:type="uml:Package" xmi:id="ID_0">
		<subvertex xmi:type="uml:State" xmi:id="ID_1">
			<incoming xmi:idref="ID_3"/>
		</subvertex>
		<transition xmi:type="uml:Transition" xmi:id="ID_3" source="ID_2" target="ID_1"/>
		<subvertex xmi:type="uml:Pseudostate" xmi:id="ID_2">
			<outgoing xmi:idref="ID_3"/>
		</subvertex>
	</packagedElement>
</xmi:XMI>'