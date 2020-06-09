Class {
	#name : #XMIATestPackage,
	#superclass : #XMIATestEntity,
	#traits : 'FamixTPackage + FamixTPackageable + FamixTWithTypes',
	#classTraits : 'FamixTPackage classTrait + FamixTPackageable classTrait + FamixTWithTypes classTrait',
	#category : #'XMI-Analyzer-Tests-Entities-Entities'
}

{ #category : #meta }
XMIATestPackage class >> annotation [

	<FMClass: #Package super: #XMIATestEntity>
	<package: #'XMI-Analyzer-Tests-Entities'>
	<generated>
	^self
]
