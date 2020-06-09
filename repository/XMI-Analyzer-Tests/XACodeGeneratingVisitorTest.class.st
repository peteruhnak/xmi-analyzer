Class {
	#name : #XACodeGeneratingVisitorTest,
	#superclass : #XAGeneratingVisitorTest,
	#category : #'XMI-Analyzer-Tests'
}

{ #category : #tests }
XACodeGeneratingVisitorTest >> testVisitDom [
	visitor useTypeNamespace: true.
	visitor visitDocument: self newSimpleDom.
	self
		assert:
			((RPackage organizer packageNamed: self packageName) classes
				collect: [ :each | each name withoutPrefix: self classPrefix ]
				as: Set)
		equals: #(#UmlState #UmlPackage #UmlPseudostate #UmlTransition) asSet
]

{ #category : #accessing }
XACodeGeneratingVisitorTest >> visitorClass [
	^ XACodeGeneratingVisitor
]
