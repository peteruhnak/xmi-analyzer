Class {
	#name : #XADelayedClassTest,
	#superclass : #XABaseTest,
	#instVars : [
		'delayedClass'
	],
	#category : #'XMI-Analyzer-Tests'
}

{ #category : #running }
XADelayedClassTest >> setUp [
	super setUp.
	delayedClass := XADelayedClass
		name: self classPrefix , 'Delayed'
		parent: Object
		package: self packageName
]

{ #category : #running }
XADelayedClassTest >> tearDown [
	delayedClass realClass ifNotNil: [ :cls | cls removeFromSystem ].
	super tearDown
]

{ #category : #tests }
XADelayedClassTest >> testAddDuplicateVariable [
	delayedClass addInstVarNamed: 'something'.
	delayedClass addInstVarNamed: 'something'.
	self assert: delayedClass instanceVariables asArray equals: #(#something)
]

{ #category : #tests }
XADelayedClassTest >> testAddInstVar [
	self assert: delayedClass instanceVariables asArray equals: #().
	delayedClass addInstVarNamed: 'something'.
	self assert: delayedClass instanceVariables asArray equals: #(#something).
	self assert: delayedClass instVarNames asArray equals: #(#something)
]

{ #category : #tests }
XADelayedClassTest >> testBasicClass [
	| cls |
	cls := delayedClass save.
	self assert: delayedClass realClass equals: cls.
	self assert: cls className equals: self classPrefix , 'Delayed class'.
	self assert: cls superclass equals: Object.
	self assert: cls package name equals: self packageName.
	self assert: cls instVarNames equals: #()
]

{ #category : #tests }
XADelayedClassTest >> testCompileMethod [
	| cls method |
	cls := Object subclass: delayedClass name.
	method := 'method ^ method'.
	self assert: cls selectors equals: #().
	delayedClass addMethod: method classified: 'accessing' to: cls.
	self assert: cls selectors equals: #(#method).
	self assert: (cls >> #method) ast equals: (RBParser parseMethod: method)
]

{ #category : #tests }
XADelayedClassTest >> testHasVariable [
	self deny: (delayedClass hasInstVarNamed: #something).
	delayedClass addInstVarNamed: #something.
	self assert: (delayedClass hasInstVarNamed: #something)
]

{ #category : #tests }
XADelayedClassTest >> testMethod [
	self assert: delayedClass selectors asSet equals: Set new.
	delayedClass compile: 'method ^ method' classified: 'accessing'.
	self assert: delayedClass selectors asSet equals: #(#method) asSet
]

{ #category : #tests }
XADelayedClassTest >> testOverrideMethod [
	| cls |
	delayedClass compile: 'method ^ 1' classified: 'accessing'.
	self assert: delayedClass selectors asSet equals: #(#method) asSet.
	delayedClass compile: 'method ^ 2' classified: 'accessing'.
	cls := delayedClass save.
	self assert: cls selectors equals: #(#method).
	self assert: (cls >> #method) ast equals: (RBParser parseMethod: 'method ^ 2')
]

{ #category : #tests }
XADelayedClassTest >> testSaveMethod [
	| cls method |
	method := 'method ^ method'.
	delayedClass compile: method classified: 'accessing'.
	cls := delayedClass save.
	self assert: cls selectors equals: #(#method).
	self assert: (cls >> #method) ast equals: (RBParser parseMethod: method)
]

{ #category : #tests }
XADelayedClassTest >> testSetup [
	self assert: delayedClass realClass equals: nil.
	self assert: delayedClass name equals: self classPrefix , 'Delayed'.
	self assert: delayedClass parent equals: Object.
	self assert: delayedClass package equals: self packageName.
	self assert: delayedClass instanceVariables asArray equals: #()
]
