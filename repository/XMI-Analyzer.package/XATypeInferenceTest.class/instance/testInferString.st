tests
testInferString
	self assert: (inference inferValue: 'ID_1') equals: #String.
	self assert: (inference inferValue: 'Name') equals: #String.
	self assert: (inference inferValue: 'public') equals: #String