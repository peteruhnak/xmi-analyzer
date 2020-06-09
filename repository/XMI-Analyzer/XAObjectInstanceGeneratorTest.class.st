Class {
	#name : #XAObjectInstanceGeneratorTest,
	#superclass : #XAAbstractGeneratorTest,
	#category : 'XMI-Analyzer-Tests'
}

{ #category : #accessing }
XAObjectInstanceGeneratorTest >> generatorClass [
	^ XAObjectInstanceGenerator
]

{ #category : #running }
XAObjectInstanceGeneratorTest >> setUp [
	| classGenVisitor |
	super setUp.
	classGenVisitor := XACodeGeneratingVisitor new.
	classGenVisitor classPrefix: generator classPrefix.
	classGenVisitor packageName: generator packageName.
	classGenVisitor visit: self newSimpleDom
]

{ #category : #running }
XAObjectInstanceGeneratorTest >> tearDown [
	"Do nothing. Don't wipe the XAG package so the classes don't have to be created for each instance test."
]

{ #category : #tests }
XAObjectInstanceGeneratorTest >> testCollectIds [
	| ids |
	ids := generator collectIdsFrom: self newSimpleDom.
	self assert: (ids collect: #key) asSet equals: #(#ID_0 #ID_1 #ID_2 #ID_3) asSet
]

{ #category : #tests }
XAObjectInstanceGeneratorTest >> testContainment [
	| parent child parentInstance childInstance dom |
	dom := self newStructureDom.
	parent := dom allElements second.
	child := parent elements first.
	parentInstance := generator createInstanceFor: parent.
	childInstance := generator createInstanceFor: child.
	self assert: parentInstance subvertex asArray equals: {childInstance}.
	self assert: childInstance owner equals: parentInstance
]

{ #category : #tests }
XAObjectInstanceGeneratorTest >> testReferenceIdref [
	| dom source outgoing |
	dom := self newSimpleDom.
	generator inferTypesIn: dom.
	dom allElements allButFirst do: [ :each | generator processElement: each ].
	generator resolveReferences.
	source := generator topInstance subvertex detect: [ :each | each name = 'Initial' ].
	outgoing := generator topInstance transition first.
	self assert: source outgoing asArray equals: {outgoing}
]

{ #category : #tests }
XAObjectInstanceGeneratorTest >> testReferenceObscure [
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
]

{ #category : #tests }
XAObjectInstanceGeneratorTest >> testSetXmi [
	| instance element |
	element := self newSimpleDom allElements third.
	instance := (generator classNameFor: element) asClass new.
	generator setXmiAttributesFrom: element to: instance.
	self assert: instance xmiId equals: (element attributeAt: #xmi:id)
]

{ #category : #tests }
XAObjectInstanceGeneratorTest >> testSingleInstance [
	| dom instance |
	dom := self newSimpleDom.
	generator inferTypesIn: dom.
	generator createInstanceFor: dom allElements second.
	instance := generator createInstanceFor: dom allElements third.
	self assert: instance name equals: 'State1'.
	self assert: instance visibility equals: 'public'.
	self assert: instance xmiId equals: 'ID_1'
]
