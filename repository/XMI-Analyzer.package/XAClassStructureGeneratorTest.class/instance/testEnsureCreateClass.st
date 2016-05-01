tests
testEnsureCreateClass
	| cls |
	cls := generator ensureCreateClass: 'XAGSomething' in: generator packageName.
	self assert: cls name equals: 'XAGSomething'.
	self assert: cls package equals: generator packageName