tests
testIdref
	self assert: (inference inferValue: 'ID_1') equals: #String.
	inference idRefs: #(#ID_1).
	self assert: (inference inferValue: 'ID_1') equals: #IDREF