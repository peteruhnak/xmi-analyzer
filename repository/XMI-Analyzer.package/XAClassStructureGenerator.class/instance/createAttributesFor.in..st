xml processing
createAttributesFor: anElement in: aClass
	(anElement attributeAt: #xmi:id)
		ifNotEmpty: [ self ensureAttributeWithAccessor: #xmiId in: aClass ].
	anElement attributeNodes
		reject: [ :each | each name includes: $: ]
		thenDo: [ :each | self ensureAttributeWithAccessor: each name in: aClass ]