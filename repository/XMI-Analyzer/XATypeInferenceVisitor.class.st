Class {
	#name : #XATypeInferenceVisitor,
	#superclass : #XMLDOMVisitor,
	#instVars : [
		'collector'
	],
	#category : 'XMI-Analyzer-Core'
}

{ #category : #accessing }
XATypeInferenceVisitor >> collector: anInferenceCollector [
	collector := anInferenceCollector
]

{ #category : #'as yet unclassified' }
XATypeInferenceVisitor >> visitElement: anElement [
	collector inferElement: anElement.
	super visitElement: anElement
]
