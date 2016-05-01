resolving
collectIdsFrom: aDocument
	^ (aDocument allElements collect: [ :each | (each attributeAt: #xmi:id) -> each ])
		reject: [ :each | each key isEmpty ]