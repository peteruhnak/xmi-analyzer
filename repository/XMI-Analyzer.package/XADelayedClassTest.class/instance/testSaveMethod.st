tests
testSaveMethod
	| cls method |
	method := 'method ^ method'.
	delayedClass compile: method classified: 'accessing'.
	cls := delayedClass save.
	self assert: cls selectors equals: #(#method).
	self assert: (cls >> #method) ast equals: (RBParser parseMethod: method)