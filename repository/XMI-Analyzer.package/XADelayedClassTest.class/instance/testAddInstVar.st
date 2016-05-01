tests
testAddInstVar
	self assert: delayedClass instanceVariables asArray equals: #().
	delayedClass addInstVarNamed: 'something'.
	self assert: delayedClass instanceVariables asArray equals: #(#something).
	self assert: delayedClass instVarNames asArray equals: #(#something)