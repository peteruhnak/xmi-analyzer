tests
tearDown
	super tearDown.
	(RPackage organizer packageNamed: self packageName) classes
		do: [ :each | each removeFromSystem ]