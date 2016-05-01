instantiating
setXmiAttributesFrom: anElement to: anInstance
	"Other attributes such as xmi:uuid are not yet supported, and #xmi:idref is handled elsewhere."

	(anElement attributeAt: #xmi:id)
		ifNotEmpty: [ :id | anInstance instVarNamed: #xmiId put: id ]