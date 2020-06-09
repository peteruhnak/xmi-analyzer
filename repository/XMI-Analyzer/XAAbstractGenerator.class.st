"
I provide some common interface to both class and object generators.
"
Class {
	#name : #XAAbstractGenerator,
	#superclass : #Object,
	#instVars : [
		'packageName',
		'classPrefix',
		'ownerReference',
		'useTypeNamespace'
	],
	#category : 'XMI-Analyzer-Core'
}

{ #category : #normalizing }
XAAbstractGenerator >> classNameFor: anElement [
	^ self classNameFor: anElement name type: (anElement attributeAt: #xmi:type)
]

{ #category : #normalizing }
XAAbstractGenerator >> classNameFor: anElementName type: aTypeName [
	| parts |
	parts := (aTypeName ifEmpty: [ anElementName ]) splitOn: ':'.
	self useTypeNamespace
		ifFalse: [ parts := {parts last} ].
	^ self classPrefix , ((parts collect: #capitalized) joinUsing: '')
]

{ #category : #accessing }
XAAbstractGenerator >> classPrefix [
	^ classPrefix
]

{ #category : #accessing }
XAAbstractGenerator >> classPrefix: aString [
	classPrefix := aString
]

{ #category : #accessing }
XAAbstractGenerator >> ownerReference [
	^ ownerReference ifNil: [ 'owner' ]
]

{ #category : #accessing }
XAAbstractGenerator >> ownerReference: aString [
	"Name to use for reference to the owner, in case there is a naming conflict."
	ownerReference := aString
]

{ #category : #accessing }
XAAbstractGenerator >> packageName [
	^ packageName
]

{ #category : #accessing }
XAAbstractGenerator >> packageName: aString [
	packageName := aString
]

{ #category : #accessing }
XAAbstractGenerator >> useTypeNamespace [
	^ useTypeNamespace ifNil: [ useTypeNamespace := false ]
]

{ #category : #accessing }
XAAbstractGenerator >> useTypeNamespace: aBoolean [
	useTypeNamespace := aBoolean
]
