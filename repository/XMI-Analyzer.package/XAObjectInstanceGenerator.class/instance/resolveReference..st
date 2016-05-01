resolving
resolveReference: anElement
	| parent child |
	anElement name = 'type'
		ifTrue: [ ^ self ].
	(anElement isRoot or: [ anElement parent isNil or: [ anElement parent isRoot ] ])
		ifTrue: [ ^ self ].
	parent := instances at: anElement parent.
	(anElement attributeAt: #xmi:idref)
		ifEmpty: [ child := instances at: anElement.
			self addReference: child to: parent at: anElement name.
			self setReference: parent to: child at: self ownerReference ]
		ifNotEmpty: [ :idref | 
			unresolved
				add: [ self addReference: (instances at: (ids at: idref)) to: parent at: anElement name ] ]