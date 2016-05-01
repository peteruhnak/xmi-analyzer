tests
testSingleInstance
	| dom instance |
	dom := self newSimpleDom.
	generator inferTypesIn: dom.
	generator createInstanceFor: dom allElements second.
	instance := generator createInstanceFor: dom allElements third.
	self assert: instance name equals: 'State1'.
	self assert: instance visibility equals: 'public'.
	self assert: instance xmiId equals: 'ID_1'