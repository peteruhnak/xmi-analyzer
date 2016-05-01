tests
testAddDuplicateVariable
	delayedClass addInstVarNamed: 'something'.
	delayedClass addInstVarNamed: 'something'.
	self assert: delayedClass instanceVariables asArray equals: #(#something)