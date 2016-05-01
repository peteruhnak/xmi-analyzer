running
setUp
	super setUp.
	generator := self generatorClass new.
	generator classPrefix: self classPrefix.
	generator packageName: self packageName