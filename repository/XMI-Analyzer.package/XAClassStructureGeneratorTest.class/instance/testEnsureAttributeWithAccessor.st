tests
testEnsureAttributeWithAccessor
	| cls |
	cls := generator ensureCreateClass: 'XAGSomething' in: generator packageName.
	self assert: cls instanceVariables asArray equals: #().
	generator ensureAttributeWithAccessor: #something in: cls.
	self assert: cls instanceVariables asSet equals: #(#something) asSet.
	self assert: cls selectors asSet equals: #(#something) asSet.
	generator createClassesInSystem.
	self
		assert: (#XAGSomething asClass >> #something) ast
		equals: (RBParser parseMethod: 'something ^ something')