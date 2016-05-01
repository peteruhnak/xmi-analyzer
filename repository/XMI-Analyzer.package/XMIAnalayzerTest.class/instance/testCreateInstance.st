tests
testCreateInstance
	| instance |
	XMIAnalyzer createClassesFor: self newDom prefixed: self classPrefix in: self packageName.
	instance := XMIAnalyzer createInstanceOf: self newDom prefixed: self classPrefix.
	self assert: instance className equals: self classPrefix , 'Model'