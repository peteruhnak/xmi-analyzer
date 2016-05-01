public API
createClassesFor: aDom prefixed: aPrefix in: aPackage
	XACodeGeneratingVisitor new
		classPrefix: aPrefix;
		packageName: aPackage;
		visit: aDom