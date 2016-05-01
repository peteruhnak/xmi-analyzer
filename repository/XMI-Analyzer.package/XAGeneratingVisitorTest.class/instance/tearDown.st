running
tearDown
	super tearDown.
	SystemAnnouncer uniqueInstance
		suspendAllWhile: [ (RPackage organizer packageNamed: self packageName) classes
				do: [ :each | each removeFromSystemUnlogged ] ]