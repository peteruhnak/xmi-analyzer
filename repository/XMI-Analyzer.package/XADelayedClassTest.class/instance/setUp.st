running
setUp
	super setUp.
	delayedClass := XADelayedClass
		name: self classPrefix , 'Delayed'
		parent: Object
		package: self packageName