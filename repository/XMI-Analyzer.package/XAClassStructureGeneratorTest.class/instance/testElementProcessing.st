tests
testElementProcessing
	self newSimpleDom allElements do: [ :each | generator processElement: each ].
	generator createClassesInSystem.
	self
		assert: (generator classPrefix , 'Pseudostate') asClass instVarNames asSet
		equals: #(#xmiId #name #visibility #kind #outgoing #owner) asSet