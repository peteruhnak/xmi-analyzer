Class {
	#name : #XAClassStructureGeneratorTest,
	#superclass : #XAAbstractGeneratorTest,
	#category : 'XMI-Analyzer-Tests'
}

{ #category : #accessing }
XAClassStructureGeneratorTest >> generatorClass [
	^ XAClassStructureGenerator
]

{ #category : #tests }
XAClassStructureGeneratorTest >> testClassName [
	generator classPrefix: ''.
	self assert: (generator classNameFor: 'tagName' type: '') equals: 'TagName'.
	self assert: (generator classNameFor: 'tagName' type: 'uml:TagName') equals: 'TagName'.
	self assert: (generator classNameFor: 'tag:name' type: '') equals: 'Name'
]

{ #category : #tests }
XAClassStructureGeneratorTest >> testClassNameForElement [
	generator classPrefix: ''.
	self assert: (generator classNameFor: (self newElement: 'tagName')) equals: 'TagName'.
	self
		assert:
			(generator
				classNameFor: (self newElement: 'tagName' attributes: {(#xmi:type -> 'uml:TagName')}))
		equals: 'TagName'
]

{ #category : #tests }
XAClassStructureGeneratorTest >> testClassNameNamespaced [
	generator classPrefix: ''.
	generator useTypeNamespace: true.
	self assert: (generator classNameFor: 'tagName' type: '') equals: 'TagName'.
	self assert: (generator classNameFor: 'tagName' type: 'uml:TagName') equals: 'UmlTagName'.
	self assert: (generator classNameFor: 'tag:name' type: '') equals: 'TagName'
]

{ #category : #tests }
XAClassStructureGeneratorTest >> testDomStructure [
	self newStructureDom allElements allButFirst
		do: [ :each | generator processElement: each ].
	generator createClassesInSystem.
	self
		assert:
			((RPackage organizer packageNamed: generator packageName) classes
				collect: [ :each | each name withoutPrefix: generator classPrefix ]) asSet
		equals: #(#State #Package #Pseudostate #Transition) asSet
]

{ #category : #tests }
XAClassStructureGeneratorTest >> testElementProcessing [
	self newSimpleDom allElements do: [ :each | generator processElement: each ].
	generator createClassesInSystem.
	self
		assert: (generator classPrefix , 'Pseudostate') asClass instVarNames asSet
		equals: #(#xmiId #name #visibility #kind #outgoing #owner) asSet
]

{ #category : #tests }
XAClassStructureGeneratorTest >> testEnsureAttributeWithAccessor [
	| cls |
	cls := generator ensureCreateClass: 'XAGSomething' in: generator packageName.
	self assert: cls instanceVariables asArray equals: #().
	generator ensureAttributeWithAccessor: #something in: cls.
	self assert: cls instanceVariables asSet equals: #(#something) asSet.
	self assert: cls selectors asSet equals: #(#something) asSet.
	generator createClassesInSystem.
	self
		assert: (#XAGSomething asClass >> #something) ast
		equals: (RBParser parseMethod: 'something ^ something')
]

{ #category : #tests }
XAClassStructureGeneratorTest >> testEnsureCreateClass [
	| cls |
	cls := generator ensureCreateClass: 'XAGSomething' in: generator packageName.
	self assert: cls name equals: 'XAGSomething'.
	self assert: cls package equals: generator packageName
]

{ #category : #tests }
XAClassStructureGeneratorTest >> testIsReference [
	self deny: (generator isReferenceOnly: (self newElement: 'el')).
	self
		assert: (generator isReferenceOnly: (self newElement: 'el' attributes: {(#xmi:idref -> 'x')}))
]

{ #category : #tests }
XAClassStructureGeneratorTest >> testOwnerReference [
	self assert: generator ownerReference equals: 'owner'.
	generator ownerReference: 'ownerReference'.
	self assert: generator ownerReference equals: 'ownerReference'
]

{ #category : #tests }
XAClassStructureGeneratorTest >> testParent [
	| dom |
	dom := self newStructureDom.
	self deny: (generator hasParent: dom root).
	self deny: (generator hasParent: dom allElements second).
	self assert: (generator hasParent: dom allElements third)
]
