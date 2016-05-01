tests
testDom
	| package dom |
	dom := self newSimpleDom.
	codeVisitor visit: dom.
	package := visitor visitDocument: dom.
	self assert: package className equals: self classPrefix , #Package.
	self assert: package subvertex size equals: 2.
	self assert: package transition size equals: 1