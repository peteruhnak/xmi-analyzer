tests
testReferenceIdref
	| dom source outgoing |
	dom := self newSimpleDom.
	generator inferTypesIn: dom.
	dom allElements allButFirst do: [ :each | generator processElement: each ].
	generator resolveReferences.
	source := generator topInstance subvertex detect: [ :each | each name = 'Initial' ].
	outgoing := generator topInstance transition first.
	self assert: source outgoing asArray equals: {outgoing}