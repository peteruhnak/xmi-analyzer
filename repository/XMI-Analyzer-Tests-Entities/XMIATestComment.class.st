Class {
	#name : #XMIATestComment,
	#superclass : #XMIATestEntity,
	#traits : 'FamixTComment + FamixTWithComments',
	#classTraits : 'FamixTComment classTrait + FamixTWithComments classTrait',
	#category : #'XMI-Analyzer-Tests-Entities-Entities'
}

{ #category : #meta }
XMIATestComment class >> annotation [

	<FMClass: #Comment super: #XMIATestEntity>
	<package: #'XMI-Analyzer-Tests-Entities'>
	<generated>
	^self
]
