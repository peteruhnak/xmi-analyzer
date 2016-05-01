tests
testInferNumber
	self assert: (inference inferValue: '1') equals: #Integer.
	self assert: (inference inferValue: '1.2') equals: #Float