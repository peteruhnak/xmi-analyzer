tests
testCompileMethod
	| cls method |
	cls := Object subclass: delayedClass name.
	method := 'method ^ method'.
	self assert: cls selectors equals: #().
	delayedClass addMethod: method classified: 'accessing' to: cls.
	self assert: cls selectors equals: #(#method).
	self assert: (cls >> #method) ast equals: (RBParser parseMethod: method)