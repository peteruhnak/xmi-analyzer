running
setUp
	super setUp.
	visitor := XACodeGeneratingVisitor new.
	visitor packageName: self packageName.
	visitor classPrefix: self classPrefix