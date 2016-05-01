inference
inferElement: anElement
	anElement attributeNodes do: [ :each | self inferAttribute: each ].
	^ self cacheAt: anElement name