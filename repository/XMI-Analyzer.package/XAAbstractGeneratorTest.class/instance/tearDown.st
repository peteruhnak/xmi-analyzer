running
tearDown
	super tearDown.
	(RPackage organizer packageNamed: generator packageName) classes
		do: [ :each | each removeFromSystemUnlogged ]