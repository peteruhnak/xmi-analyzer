tests
testIdrefs
	self assert: (inference inferValue: 'ID_1 ID_2') equals: #String.
	inference idRefs: #(#ID_1 #ID_2).
	self assert: (inference inferValue: 'ID_1 ID_2') equals: #IDREFS