public API
createInstanceOf: aDom prefixed: aPrefix
	^ XAInstanceGeneratingVisitor new
		classPrefix: aPrefix;
		visit: aDom