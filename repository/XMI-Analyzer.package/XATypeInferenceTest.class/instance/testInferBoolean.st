tests
testInferBoolean
	self assert: (inference inferValue: 'true') equals: #Boolean.
	self assert: (inference inferValue: 'false') equals: #Boolean