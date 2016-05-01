code generation
ensureAttributeWithAccessor: aName in: aClass
	aClass addInstVarNamed: aName.
	aClass
		compile:
			('{1}
	^ {1}' format: {aName})
		classified: 'accessing'