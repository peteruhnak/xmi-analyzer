running
setUp
	| classGenVisitor |
	super setUp.
	classGenVisitor := XACodeGeneratingVisitor new.
	classGenVisitor classPrefix: generator classPrefix.
	classGenVisitor packageName: generator packageName.
	classGenVisitor visit: self newSimpleDom