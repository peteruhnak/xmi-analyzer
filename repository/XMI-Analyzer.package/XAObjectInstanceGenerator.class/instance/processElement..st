public
processElement: anElement
	(anElement attributeAt: #xmi:idref)
		ifNotEmpty: [ self resolveReference: anElement ]
		ifEmpty: [ self createInstanceFor: anElement ]