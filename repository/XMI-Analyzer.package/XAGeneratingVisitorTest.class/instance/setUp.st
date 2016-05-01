running
setUp
	super setUp.
	(visitor := self visitorClass new)
		packageName: self packageName;
		useTypeNamespace: false;
		classPrefix: self classPrefix