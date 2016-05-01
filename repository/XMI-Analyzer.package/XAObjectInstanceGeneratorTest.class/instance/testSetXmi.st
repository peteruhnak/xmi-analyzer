tests
testSetXmi
	| instance element |
	element := self newSimpleDom allElements third.
	instance := (generator classNameFor: element) asClass new.
	generator setXmiAttributesFrom: element to: instance.
	self assert: instance xmiId equals: (element attributeAt: #xmi:id)