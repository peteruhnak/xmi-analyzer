"
I analyze an XMI file and generate a semi-appropriate object representation by creating new classes in a target package.
"
Class {
	#name : #XAClassStructureGenerator,
	#superclass : #XAAbstractGenerator,
	#instVars : [
		'classes'
	],
	#category : 'XMI-Analyzer-Core'
}

{ #category : #accessing }
XAClassStructureGenerator >> classFor: aName [
	^ classes at: aName
]

{ #category : #'xml processing' }
XAClassStructureGenerator >> createAttributesFor: anElement in: aClass [
	(anElement attributeAt: #xmi:id)
		ifNotEmpty: [ self ensureAttributeWithAccessor: #xmiId in: aClass ].
	anElement attributeNodes
		reject: [ :each | each name includes: $: ]
		thenDo: [ :each | self ensureAttributeWithAccessor: each name in: aClass ]
]

{ #category : #'xml processing' }
XAClassStructureGenerator >> createClassFor: anElement [
	| cls |
	cls := self ensureCreateClass: (self classNameFor: anElement) in: self packageName.
	self createAttributesFor: anElement in: cls
]

{ #category : #'code generation' }
XAClassStructureGenerator >> createClassesInSystem [
	classes do: #save
]

{ #category : #'code generation' }
XAClassStructureGenerator >> ensureAttributeWithAccessor: aName in: aClass [
	aClass addInstVarNamed: aName.
	aClass
		compile:
			('{1}
	^ {1}' format: {aName})
		classified: 'accessing'
]

{ #category : #'code generation' }
XAClassStructureGenerator >> ensureCreateClass: aName in: aPackage [
	^ classes
		at: aName
		ifAbsentPut: [ XADelayedClass name: aName parent: Object package: aPackage ]
]

{ #category : #testing }
XAClassStructureGenerator >> hasParent: anElement [
	"The topmost root is not generated, so don't generate accessors there. Some tests also provide just a fragment of XML tree which would fail on missing parent."

	^ (anElement isRoot or: [ anElement parent isNotNil and: [ anElement parent isRoot ] ])
		not
]

{ #category : #initialization }
XAClassStructureGenerator >> initialize [
	super initialize.
	classes := Dictionary new
]

{ #category : #testing }
XAClassStructureGenerator >> isReferenceOnly: anElement [
	^ (anElement attributeAt: #xmi:idref) isNotEmpty
]

{ #category : #'xml processing' }
XAClassStructureGenerator >> processElement: anElement [
	(self isReferenceOnly: anElement)
		ifFalse: [ self createClassFor: anElement.
			self
				ensureAttributeWithAccessor: self ownerReference
				in: (self classFor: (self classNameFor: anElement)) ].
	(self hasParent: anElement)
		ifTrue: [ self
				ensureAttributeWithAccessor: anElement name
				in: (self classFor: (self classNameFor: anElement parent)) ]
]
