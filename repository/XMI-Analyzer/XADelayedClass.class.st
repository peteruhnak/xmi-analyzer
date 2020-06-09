"
I am a delayed class generation object to save some time during the code generation process, because of this:

```
Something removeFromSystem.
[
	cls := Object subclass: #Something instanceVariableNames: 'someVar otherVar'
] timeToRun humanReadablePrintString. ""'120 milliseconds'""

Something removeFromSystem.
[
	cls := Object subclass: #Something.
	cls addInstVarNamed: 'someVar'.
	cls addInstVarNamed: 'otherVar'.
] timeToRun humanReadablePrintString. ""'1 second 492 milliseconds'""
```
"
Class {
	#name : #XADelayedClass,
	#superclass : #Object,
	#instVars : [
		'name',
		'parent',
		'package',
		'instanceVariables',
		'methods'
	],
	#category : #'XMI-Analyzer-Utility'
}

{ #category : #'as yet unclassified' }
XADelayedClass class >> name: aString parent: aClass package: aPkgName [
	^ self new
		name: aString;
		parent: aClass;
		package: aPkgName;
		yourself
]

{ #category : #adding }
XADelayedClass >> addInstVarNamed: aString [
	instanceVariables add: aString
]

{ #category : #generating }
XADelayedClass >> addMethod: aString classified: aProtocol to: aClass [
	aClass compile: aString classified: aProtocol
	
]

{ #category : #adding }
XADelayedClass >> compile: aString classified: aProtocol [
	| ast |
	ast := RBParser parseMethod: aString.
	methods at: ast selector put: aProtocol -> aString
]

{ #category : #testing }
XADelayedClass >> hasInstVarNamed: aString [
	^ instanceVariables includes: aString
]

{ #category : #initialization }
XADelayedClass >> initialize [
	super initialize.
	instanceVariables := Set new.
	methods := Dictionary new
]

{ #category : #accessing }
XADelayedClass >> instVarNames [
	^ self instanceVariables
]

{ #category : #accessing }
XADelayedClass >> instanceVariables [
	^ instanceVariables asArray
]

{ #category : #accessing }
XADelayedClass >> name [
	^ name
]

{ #category : #accessing }
XADelayedClass >> name: aString [
	name := aString
]

{ #category : #accessing }
XADelayedClass >> package [
	^ package
]

{ #category : #accessing }
XADelayedClass >> package: aString [
	package := aString
]

{ #category : #accessing }
XADelayedClass >> parent [
	^ parent
]

{ #category : #accessing }
XADelayedClass >> parent: aClass [
	parent := aClass
]

{ #category : #accessing }
XADelayedClass >> realClass [
	^ (Smalltalk hasClassNamed: self name)
		ifTrue: [ self name asClass ]
		ifFalse: [ nil ]
]

{ #category : #generating }
XADelayedClass >> save [
	| cls |
	cls := self saveClass.
	methods do: [ :pair | self addMethod: pair value classified: pair key to: cls ].
	^ cls
]

{ #category : #generating }
XADelayedClass >> saveClass [
	self assert: [ name isString & name isNotEmpty ].
	self assert: [ parent isClass ].
	self assert: [ instanceVariables isCollection ].
	self assert: [ instanceVariables allSatisfy: #isString ].
	self assert: [ package isString & package isNotEmpty ].
	^ parent
		subclass: name
		instanceVariableNames: (self instanceVariables joinUsing: ' ')
		classVariableNames: ''
		poolDictionaries: ''
		category: package
]

{ #category : #accessing }
XADelayedClass >> selectors [
	^ methods keys
]
