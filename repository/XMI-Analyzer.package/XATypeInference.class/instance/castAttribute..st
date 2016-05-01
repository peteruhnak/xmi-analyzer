as yet unclassified
castAttribute: anAttribute
	| type |
	type := self typeForAttribute: anAttribute.
	type = #Boolean
		ifTrue: [ ^ anAttribute value = 'true' ].
	type = #Number | (type = #Integer) | (type = #Float)
		ifTrue: [ ^ anAttribute value asNumber ].
	type = #IDREFS
		ifTrue: [ ^ anAttribute value
				ifEmpty: [ #() ]
				ifNotEmpty: [ (anAttribute value splitOn: ' ') asArray ] ].
	^ anAttribute value