tests
testHasVariable
	self deny: (delayedClass hasInstVarNamed: #something).
	delayedClass addInstVarNamed: #something.
	self assert: (delayedClass hasInstVarNamed: #something)