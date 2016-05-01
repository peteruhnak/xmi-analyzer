as yet unclassified
collectIdsFrom: aDocument
	^ (aDocument allElements collect: [ :each | each attributeAt: #xmi:id ]) reject: #isEmpty