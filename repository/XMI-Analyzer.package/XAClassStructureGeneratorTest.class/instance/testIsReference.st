tests
testIsReference
	self deny: (generator isReferenceOnly: (self newElement: 'el')).
	self
		assert: (generator isReferenceOnly: (self newElement: 'el' attributes: {(#xmi:idref -> 'x')}))