instantiating
setAttributesFrom: anElement to: instance
	anElement attributeNodes
		select: [ :each | (each name includes: $:) not ]
		thenDo: [ :each | 
			| type value |
			type := inference typeForAttribute: each.
			value := inference castAttribute: each.
			type = #IDREF
				ifTrue: [ unresolved
						add: [ self setReference: (instances at: (ids at: value)) to: instance at: each name ] ].
			type = #IDREFS
				ifTrue: [ unresolved
						add: [ value
								do:
									[ :val | self addReference: (instances at: (ids at: val)) to: instance at: each name ] ] ].
			type = #IDREF | (type = #IDREFS)
				ifFalse: [ instance instVarNamed: each name put: value ] ]