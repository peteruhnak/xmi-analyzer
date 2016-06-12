visiting
visitElement: anElement
	| result |
	result := true.
	(anElement name beginsWith: 'xmi:')
		ifFalse: [ result := generator processElement: anElement ].
	result ifNotNil: [ ^ super visitElement: anElement ]