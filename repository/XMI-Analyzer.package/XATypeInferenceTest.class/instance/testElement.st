tests
testElement
	| element |
	element := XMLElement
		name: 'name'
		attributes: (Dictionary with: #name -> 'Str' with: #prop -> 'false').
	self
		assert: (inference inferElement: element)
		equals: (Dictionary with: #name -> #String with: #prop -> #Boolean)