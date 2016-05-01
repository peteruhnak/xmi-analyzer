tests
testCache
	self assert: (inference cacheAt: #A at: #B) equals: #EMPTY.
	inference cacheAt: #A at: #B put: 42.
	self assert: (inference cacheAt: #A at: #B) equals: 42