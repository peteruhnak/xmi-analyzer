tests
testContainment
	| parent child parentInstance childInstance dom |
	dom := self newStructureDom.
	parent := dom allElements second.
	child := parent elements first.
	parentInstance := generator createInstanceFor: parent.
	childInstance := generator createInstanceFor: child.
	self assert: parentInstance subvertex asArray equals: {childInstance}.
	self assert: childInstance owner equals: parentInstance