visiting
visitElement: anElement
	(anElement name beginsWith: 'xmi:')
		ifFalse: [ generator processElement: anElement ].
	^ super visitElement: anElement