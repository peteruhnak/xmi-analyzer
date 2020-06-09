Class {
	#name : #XMIATestEnum,
	#superclass : #XMIATestEntity,
	#traits : 'FamixTType + FamixTWithEnumValues',
	#classTraits : 'FamixTType classTrait + FamixTWithEnumValues classTrait',
	#category : #'XMI-Analyzer-Tests-Entities-Entities'
}

{ #category : #meta }
XMIATestEnum class >> annotation [

	<FMClass: #Enum super: #XMIATestEntity>
	<package: #'XMI-Analyzer-Tests-Entities'>
	<generated>
	^self
]
