running
setUp
	super setUp.
	(codeVisitor := XACodeGeneratingVisitor new)
		packageName: self packageName;
		classPrefix: self classPrefix