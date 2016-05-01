accessing
useTypeNamespace: aBoolean
	"XMI often has namespaces in types, e.g. <subvertex xmi:type='uml:State' xmi:id='ID_1'>.
	true -> use 'uml:State' as type
	false -> use 'State' as type"

	generator useTypeNamespace: aBoolean