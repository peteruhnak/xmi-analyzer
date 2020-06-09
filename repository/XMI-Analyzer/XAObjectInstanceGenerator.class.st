"
I instantiate XMI elements as objects on classes generated from XMIClassStructureGenerator
"
Class {
	#name : #XAObjectInstanceGenerator,
	#superclass : #XAAbstractGenerator,
	#instVars : [
		'inference',
		'classGenerator',
		'topInstance',
		'instances',
		'ids',
		'unresolved'
	],
	#category : 'XMI-Analyzer-Core'
}

{ #category : #instantiating }
XAObjectInstanceGenerator >> addReference: aChild to: aParent at: aName [
	(aParent instVarNamed: aName)
		ifNil: [ aParent instVarNamed: aName put: OrderedCollection new ].
	(aParent instVarNamed: aName) add: aChild
]

{ #category : #resolving }
XAObjectInstanceGenerator >> collectIdsFrom: aDocument [
	^ (aDocument allElements collect: [ :each | (each attributeAt: #xmi:id) -> each ])
		reject: [ :each | each key isEmpty ]
]

{ #category : #instantiating }
XAObjectInstanceGenerator >> createInstanceFor: anElement [
	| name |
	name := self classNameFor: anElement.
	name ifNil: [ ^ nil ].
	^ self createInstanceFor: anElement class: name asClass
]

{ #category : #instantiating }
XAObjectInstanceGenerator >> createInstanceFor: anElement class: aClass [
	| instance |
	instance := aClass new.
	self setXmiAttributesFrom: anElement to: instance.
	self setAttributesFrom: anElement to: instance.
	instances ifEmpty: [ topInstance := instance ].
	instances at: anElement put: instance.
	self resolveReference: anElement.
	^ instance
]

{ #category : #resolving }
XAObjectInstanceGenerator >> inferTypesIn: aDocument [
	ids := (self collectIdsFrom: aDocument) asDictionary.
	inference := XATypeInference new.
	inference inferDocument: aDocument.
	^ inference
]

{ #category : #initialization }
XAObjectInstanceGenerator >> initialize [
	super initialize.
	ids := Dictionary new.
	inference := XATypeInference new.
	instances := Dictionary new.
	unresolved := OrderedCollection new
]

{ #category : #public }
XAObjectInstanceGenerator >> processElement: anElement [
	^ (anElement attributeAt: #xmi:idref)
		ifNotEmpty: [ self resolveReference: anElement ]
		ifEmpty: [ self createInstanceFor: anElement ]
]

{ #category : #resolving }
XAObjectInstanceGenerator >> resolveReference: anElement [
	| parent child |
	anElement name = 'type'
		ifTrue: [ ^ self ].
	(anElement isRoot or: [ anElement parent isNil or: [ anElement parent isRoot ] ])
		ifTrue: [ ^ self ].
	parent := instances at: anElement parent.
	(anElement attributeAt: #xmi:idref)
		ifEmpty: [ child := instances at: anElement.
			self addReference: child to: parent at: anElement name.
			self setReference: parent to: child at: self ownerReference ]
		ifNotEmpty: [ :idref | 
			unresolved
				add: [ self addReference: (instances at: (ids at: idref)) to: parent at: anElement name ] ]
]

{ #category : #resolving }
XAObjectInstanceGenerator >> resolveReferences [
	unresolved do: #value
]

{ #category : #instantiating }
XAObjectInstanceGenerator >> setAttributesFrom: anElement to: instance [
	anElement attributeNodes
		select: [ :each | (each name includes: $:) not ]
		thenDo: [ :each | 
			| type value |
			type := inference typeForAttribute: each.
			value := inference castAttribute: each.
			type = #IDREF
				ifTrue: [ unresolved add: [ self setReference: (instances at: (ids at: value)) to: instance at: each name ] ].
			type = #IDREFS
				ifTrue:
					[ unresolved add: [ value do: [ :val | self addReference: (instances at: (ids at: val)) to: instance at: each name ] ] ].
			type = #IDREF | (type = #IDREFS)
				ifFalse: [ self setReference: value to: instance at: each name ] ]
]

{ #category : #instantiating }
XAObjectInstanceGenerator >> setReference: aChild to: aParent at: aName [
	aParent instVarNamed: aName put: aChild
]

{ #category : #instantiating }
XAObjectInstanceGenerator >> setXmiAttributesFrom: anElement to: anInstance [
	"Other attributes such as xmi:uuid are not yet supported, and #xmi:idref is handled elsewhere."

	(anElement attributeAt: #xmi:id)
		ifNotEmpty: [ :id | anInstance instVarNamed: #xmiId put: id ]
]

{ #category : #accessing }
XAObjectInstanceGenerator >> topInstance [
	^ topInstance
]
