Class {
	#name : #XMIATestEntity,
	#superclass : #MooseEntity,
	#category : #'XMI-Analyzer-Tests-Entities-Entities'
}

{ #category : #meta }
XMIATestEntity class >> annotation [

	<FMClass: #Entity super: #MooseEntity>
	<package: #'XMI-Analyzer-Tests-Entities'>
	<generated>
	^self
]

{ #category : #meta }
XMIATestEntity class >> metamodel [

	<generated>
	^ XMIATestModel metamodel
]

{ #category : #testing }
XMIATestEntity >> isAssociation [

	<generated>
	^ false
]

{ #category : #testing }
XMIATestEntity >> isClass [

	<generated>
	^ false
]

{ #category : #testing }
XMIATestEntity >> isInheritance [

	<generated>
	^ false
]

{ #category : #testing }
XMIATestEntity >> isPackage [

	<generated>
	^ false
]

{ #category : #testing }
XMIATestEntity >> isType [

	<generated>
	^ false
]
