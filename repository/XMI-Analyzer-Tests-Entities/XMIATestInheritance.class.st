Class {
	#name : #XMIATestInheritance,
	#superclass : #XMIATestEntity,
	#traits : 'FamixTInheritance',
	#classTraits : 'FamixTInheritance classTrait',
	#category : #'XMI-Analyzer-Tests-Entities-Entities'
}

{ #category : #meta }
XMIATestInheritance class >> annotation [

	<FMClass: #Inheritance super: #XMIATestEntity>
	<package: #'XMI-Analyzer-Tests-Entities'>
	<generated>
	^self
]
