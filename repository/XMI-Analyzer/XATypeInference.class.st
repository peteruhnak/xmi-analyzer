"
I provide a basic type inferencing for the XMI document.

Most importantly I analyze which attributes are IDREF and IDREFS, so the instantiator can create correct references.
"
Class {
	#name : #XATypeInference,
	#superclass : #Object,
	#instVars : [
		'visitor',
		'idRefs',
		'cache'
	],
	#category : 'XMI-Analyzer-Core'
}

{ #category : #accessing }
XATypeInference >> cacheAt: elementName [
	^ cache at: elementName asSymbol ifAbsentPut: [ Dictionary new ]
]

{ #category : #accessing }
XATypeInference >> cacheAt: elementName at: attributeKey [
	^ (cache at: elementName asSymbol ifAbsentPut: [ Dictionary new ])
		at: attributeKey asSymbol
		ifAbsentPut: [ #EMPTY ]
]

{ #category : #accessing }
XATypeInference >> cacheAt: elementName at: attributeKey put: aValue [
	^ (cache at: elementName asSymbol ifAbsentPut: [ Dictionary new ])
		at: attributeKey asSymbol
		put: aValue
]

{ #category : #'as yet unclassified' }
XATypeInference >> castAttribute: anAttribute [
	| type |
	type := self typeForAttribute: anAttribute.
	type = #Boolean
		ifTrue: [ ^ anAttribute value = 'true' ].
	type = #Number | (type = #Integer) | (type = #Float)
		ifTrue: [ ^ anAttribute value asNumber ].
	type = #IDREFS
		ifTrue: [ ^ anAttribute value
				ifEmpty: [ #() ]
				ifNotEmpty: [ (anAttribute value splitOn: ' ') asArray ] ].
	^ anAttribute value
]

{ #category : #'as yet unclassified' }
XATypeInference >> chooseBetween: oneType and: secondType [
	| types |
	types := Set with: oneType with: secondType.
	types size = 1
		ifTrue: [ ^ types anyOne ].
	(types includes: #String)
		ifTrue: [ ^ #String ].
	(types includes: #EMPTY)
		ifTrue: [ ^ types detect: [ :each | (each = #EMPTY) not ] ].
	(types includes: #Integer)
		ifTrue: [ ^ types detect: [ :each | (each = #Integer) not ] ].
	(types includes: #IDREF) & (types includes: #IDREFS)
		ifTrue: [ ^ #IDREFS ].
	self error: 'Unhandled case'
]

{ #category : #'as yet unclassified' }
XATypeInference >> collectIdsFrom: aDocument [
	^ ((aDocument allElements collect: [ :each | each attributeAt: #xmi:id ]) reject: #isEmpty) asSet
]

{ #category : #accessing }
XATypeInference >> idRefs: aCollection [
	idRefs := aCollection
]

{ #category : #inference }
XATypeInference >> inferAttribute: anAttribute [
	| type previous newType |
	type := anAttribute name = #xmi:id
		ifTrue: [ #ID ]
		ifFalse: [ self inferValue: anAttribute value ].
	previous := self cacheAt: anAttribute element name at: anAttribute name.
	newType := self chooseBetween: type and: previous.
	self cacheAt: anAttribute element name at: anAttribute name put: newType.
	^ newType
]

{ #category : #inference }
XATypeInference >> inferDocument: aDocument [
	idRefs := self collectIdsFrom: aDocument.
	(visitor := XATypeInferenceVisitor new) collector: self.
	visitor visit: aDocument.
	^ cache
]

{ #category : #inference }
XATypeInference >> inferElement: anElement [
	anElement attributeNodes do: [ :each | self inferAttribute: each ].
	^ self cacheAt: anElement name
]

{ #category : #inference }
XATypeInference >> inferValue: aString [
	aString ifEmpty: [ ^ #EMPTY ].
	aString = 'true' | (aString = 'false')
		ifTrue: [ ^ #Boolean ].
	(NumberParser isNumber: aString)
		ifTrue: [ | num |
			num := NumberParser parse: aString.
			num isInteger
				ifTrue: [ ^ #Integer ].
			num isFloat
				ifTrue: [ ^ #Float ].
			^ #Number ].
	(idRefs includes: aString)
		ifTrue: [ ^ #IDREF ].
	((aString splitOn: ' ') allSatisfy: [ :each | idRefs includes: each ])
		ifTrue: [ ^ #IDREFS ].
	^ #String
]

{ #category : #initialization }
XATypeInference >> initialize [
	super initialize.
	idRefs := Set new.
	cache := Dictionary new
]

{ #category : #accessing }
XATypeInference >> typeForAttribute: anAttribute [
	^ self cacheAt: anAttribute element name at: anAttribute name
]
