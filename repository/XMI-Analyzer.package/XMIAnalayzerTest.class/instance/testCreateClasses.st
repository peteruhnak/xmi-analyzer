tests
testCreateClasses
	XMIAnalyzer createClassesFor: self newDom prefixed: self classPrefix in: self packageName.
	self assert: (RPackage organizer packageNamed: self packageName) classes isNotEmpty