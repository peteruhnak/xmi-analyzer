Class {
	#name : #XAInstanceGeneratingVisitorTest,
	#superclass : #XAGeneratingVisitorTest,
	#instVars : [
		'codeVisitor'
	],
	#category : 'XMI-Analyzer-Tests'
}

{ #category : #running }
XAInstanceGeneratingVisitorTest >> setUp [
	super setUp.
	(codeVisitor := XACodeGeneratingVisitor new)
		packageName: self packageName;
		classPrefix: self classPrefix
]

{ #category : #tests }
XAInstanceGeneratingVisitorTest >> testDom [
	| package dom |
	dom := self newSimpleDom.
	codeVisitor visit: dom.
	package := visitor visitDocument: dom.
	self assert: package className equals: self classPrefix , #Package.
	self assert: package subvertex size equals: 2.
	self assert: package transition size equals: 1
]

{ #category : #accessing }
XAInstanceGeneratingVisitorTest >> visitorClass [
	^ XAInstanceGeneratingVisitor
]
