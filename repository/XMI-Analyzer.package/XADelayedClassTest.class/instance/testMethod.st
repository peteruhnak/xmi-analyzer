tests
testMethod
	self assert: delayedClass selectors asSet equals: Set new.
	delayedClass compile: 'method ^ method' classified: 'accessing'.
	self assert: delayedClass selectors asSet equals: #(#method) asSet