Class {
	#name : #XMIAnalayzerTest,
	#superclass : #XABaseTest,
	#category : #'XMI-Analyzer-Tests'
}

{ #category : #'instance creation' }
XMIAnalayzerTest >> newDom [
	^ XMIAnalyzer sampleStateMachineXmi
]

{ #category : #running }
XMIAnalayzerTest >> tearDown [
	self cleanUpPackage.
	super tearDown
]

{ #category : #tests }
XMIAnalayzerTest >> testCreateClasses [
	XMIAnalyzer createClassesFor: self newDom prefixed: self classPrefix in: self packageName.
	self denyEmpty: (RPackage organizer packageNamed: self packageName) classes
]

{ #category : #tests }
XMIAnalayzerTest >> testCreateInstance [
	| instance |
	XMIAnalyzer createClassesFor: self newDom prefixed: self classPrefix in: self packageName.
	instance := XMIAnalyzer createInstanceOf: self newDom prefixed: self classPrefix.
	self assert: instance className equals: self classPrefix , 'Model'
]

{ #category : #'tests - naive' }
XMIAnalayzerTest >> testExample [
	XMIAnalyzer exampleStateMachineScenario
]

{ #category : #'tests - naive' }
XMIAnalayzerTest >> testSample [
	XMIAnalyzer sampleStateMachineScenario
]
