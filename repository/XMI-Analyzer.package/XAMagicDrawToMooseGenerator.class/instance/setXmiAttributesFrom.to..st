instantiating
setXmiAttributesFrom: anElement to: anInstance
	"Moose uses numeric IDs, so I am not sure what should be the proper behavior here.. maybe a mapping table between MagicDraw IDs and Moose IDs"

	(anElement attributeAt: #xmi:id)
		ifNotEmpty: [ :id | anInstance instVarNamed: #mooseID put: id ]