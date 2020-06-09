Class {
	#name : #XAAbstractGeneratingVisitor,
	#superclass : #XMLDOMVisitor,
	#instVars : [
		'generator'
	],
	#category : 'XMI-Analyzer-Core'
}

{ #category : #accessing }
XAAbstractGeneratingVisitor >> classPrefix: aString [
	generator classPrefix: aString
]

{ #category : #accessing }
XAAbstractGeneratingVisitor >> generatorClass [
	^ self subclassResponsibility
]

{ #category : #initialization }
XAAbstractGeneratingVisitor >> initialize [
	super initialize.
	generator := self generatorClass new
]

{ #category : #accessing }
XAAbstractGeneratingVisitor >> packageName: aPackageName [
	generator packageName: aPackageName
	
]

{ #category : #accessing }
XAAbstractGeneratingVisitor >> useTypeNamespace: aBoolean [
	"XMI often has namespaces in types, e.g. <subvertex xmi:type='uml:State' xmi:id='ID_1'>.
	true -> use 'uml:State' as type
	false -> use 'State' as type"

	generator useTypeNamespace: aBoolean
]
