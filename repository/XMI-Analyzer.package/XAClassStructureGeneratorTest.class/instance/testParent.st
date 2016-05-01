tests
testParent
	| dom |
	dom := self newStructureDom.
	self deny: (generator hasParent: dom root).
	self deny: (generator hasParent: dom allElements second).
	self assert: (generator hasParent: dom allElements third)