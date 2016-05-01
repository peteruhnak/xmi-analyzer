instantiating
addReference: aChild to: aParent at: aName
	(aParent instVarNamed: aName)
		ifNil: [ aParent instVarNamed: aName put: OrderedCollection new ].
	(aParent instVarNamed: aName) add: aChild