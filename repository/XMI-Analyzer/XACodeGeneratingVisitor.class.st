Class {
	#name : #XACodeGeneratingVisitor,
	#superclass : #XAAbstractGeneratingVisitor,
	#category : 'XMI-Analyzer-Core'
}

{ #category : #accessing }
XACodeGeneratingVisitor >> generatorClass [
	^ XAClassStructureGenerator
]

{ #category : #visiting }
XACodeGeneratingVisitor >> visitDocument: aDocument [
	super visitDocument: aDocument.
	generator createClassesInSystem
]

{ #category : #visiting }
XACodeGeneratingVisitor >> visitElement: anElement [
	(anElement name beginsWith: 'xmi:')
		ifFalse: [ generator processElement: anElement ].
	^ super visitElement: anElement
]
