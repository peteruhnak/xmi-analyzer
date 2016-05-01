tests
testOverrideMethod
	| cls |
	delayedClass compile: 'method ^ 1' classified: 'accessing'.
	self assert: delayedClass selectors asSet equals: #(#method) asSet.
	delayedClass compile: 'method ^ 2' classified: 'accessing'.
	cls := delayedClass save.
	self assert: cls selectors equals: #(#method).
	self assert: (cls >> #method) ast equals: (RBParser parseMethod: 'method ^ 2')