tests
testVisitDom
	visitor useTypeNamespace: true.
	visitor visitDocument: self newSimpleDom.
	self
		assert:
			((RPackage organizer packageNamed: self packageName) classes
				collect: [ :each | each name withoutPrefix: self classPrefix ]
				as: Set)
		equals: #(#UmlState #UmlPackage #UmlPseudostate #UmlTransition) asSet