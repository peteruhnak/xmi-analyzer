testing
isReferenceOnly: anElement
	^ (anElement attributeAt: #xmi:idref) isNotEmpty