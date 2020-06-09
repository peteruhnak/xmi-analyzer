Class {
	#name : #XAInstanceGeneratingVisitor,
	#superclass : #XAAbstractGeneratingVisitor,
	#instVars : [
		'instance'
	],
	#category : 'XMI-Analyzer-Core'
}

{ #category : #accessing }
XAInstanceGeneratingVisitor >> generator [
	^ generator
]

{ #category : #accessing }
XAInstanceGeneratingVisitor >> generator: aGenerator [
	generator := aGenerator
]

{ #category : #accessing }
XAInstanceGeneratingVisitor >> generatorClass [
	^ XAObjectInstanceGenerator
]

{ #category : #visiting }
XAInstanceGeneratingVisitor >> visit: aDocument [
	super visit: aDocument.
	^ instance
]

{ #category : #visiting }
XAInstanceGeneratingVisitor >> visitDocument: aDocument [
	generator inferTypesIn: aDocument.
	super visitDocument: aDocument.
	generator resolveReferences.
	instance := generator topInstance.
	^ instance
]

{ #category : #visiting }
XAInstanceGeneratingVisitor >> visitElement: anElement [
	| result |
	result := true.
	(anElement name beginsWith: 'xmi:')
		ifFalse: [ result := generator processElement: anElement ].
	result ifNotNil: [ ^ super visitElement: anElement ]
]
