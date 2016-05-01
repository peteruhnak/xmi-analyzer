tests
testDomStructure
	self newStructureDom allElements allButFirst
		do: [ :each | generator processElement: each ].
	generator createClassesInSystem.
	self
		assert:
			((RPackage organizer packageNamed: generator packageName) classes
				collect: [ :each | each name withoutPrefix: generator classPrefix ]) asSet
		equals: #(#State #Package #Pseudostate #Transition) asSet