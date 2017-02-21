instantiating
resolveReference: anElement
	anElement name = 'type'
		ifTrue: [ ^ self ].
	(anElement isRoot or: [ anElement parent isNil or: [ anElement parent isRoot ] ])
		ifTrue: [ ^ self ].
	parent := instances at: anElement parent.
	(anElement attributeAt: #xmi:idref)
		ifEmpty: [ node := instances at: anElement.
			currentElement := anElement.
			self addReference: node to: parent at: anElement name.
			self setReference: parent to: node at: self ownerReference ]
		ifNotEmpty: [ :idref | 
			unresolved
				add: [ self addReference: (instances at: (ids at: idref)) to: parent at: anElement name ] ]