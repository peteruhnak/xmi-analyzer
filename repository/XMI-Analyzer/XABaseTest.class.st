Class {
	#name : #XABaseTest,
	#superclass : #TestCase,
	#category : 'XMI-Analyzer-Tests'
}

{ #category : #accessing }
XABaseTest >> classPrefix [
	^ 'XAG'
]

{ #category : #running }
XABaseTest >> cleanUpPackage [
	(RPackage organizer includesPackageNamed: self packageName)
		ifTrue: [ (RPackage organizer packageNamed: self packageName) classes
				do: [ :each | each removeFromSystemUnlogged ] ]
]

{ #category : #accessing }
XABaseTest >> packageName [
	^ 'GeneratedClassesForXMITests'
]
