tests
testReferenceObscure
	| source dom transition target |
	dom := self newSimpleDom.
	generator inferTypesIn: dom.
	dom allElements allButFirst do: [ :each | generator processElement: each ].
	generator resolveReferences.
	transition := generator topInstance transition first.
	source := generator topInstance subvertex detect: [ :each | each name = 'Initial' ].
	target := generator topInstance subvertex detect: [ :each | each name = 'State1' ].
	self assert: transition source equals: source.
	self assert: transition target equals: target