tests
testClassNameForElement
	generator classPrefix: ''.
	self assert: (generator classNameFor: (self newElement: 'tagName')) equals: 'TagName'.
	self
		assert:
			(generator
				classNameFor: (self newElement: 'tagName' attributes: {(#xmi:type -> 'uml:TagName')}))
		equals: 'TagName'