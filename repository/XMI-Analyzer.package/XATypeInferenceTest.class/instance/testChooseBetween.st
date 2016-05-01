tests
testChooseBetween
	self assert: (inference chooseBetween: #String and: #String) equals: #String.
	self assert: (inference chooseBetween: #Integer and: #String) equals: #String.
	self assert: (inference chooseBetween: #EMPTY and: #String) equals: #String.
	self assert: (inference chooseBetween: #IDREF and: #IDREFS) equals: #IDREFS.
	self assert: (inference chooseBetween: #Integer and: #Number) equals: #Number.
	self assert: (inference chooseBetween: #Integer and: #Float) equals: #Float.
	self assert: (inference chooseBetween: #ID and: #ID) equals: #ID.