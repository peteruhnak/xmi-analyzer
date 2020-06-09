"
Description
--------------------

One line summary. For example, ""I represent a paragraph of text"".

Three sentences about my main responsibilities - what I do, what I know.

State my main collaborators and one line about how I interact with them. 

Public API and Key Messages
--------------------

- #
- #
- #

Examples
--------------------

	
 
Internal Representation and Key Implementation Points.
--------------------

    Instance Variables
	access:		<Object>
	attribute:		<Object>
	class:		<Object>
	entity:		<Object>
	invocation:		<Object>
	method:		<Object>
	package:		<Object>
	sourceTextAnchor:		<Object>

"
Class {
	#name : #XMIAnalyzerTestGenerator,
	#superclass : #FamixMetamodelGenerator,
	#instVars : [
		'class',
		'package',
		'enum',
		'inheritance',
		'comment'
	],
	#category : #'XMI-Analyzer-Tests-Generator'
}

{ #category : #accessing }
XMIAnalyzerTestGenerator class >> packageName [
	^ #'XMI-Analyzer-Tests-Entities'
]

{ #category : #accessing }
XMIAnalyzerTestGenerator class >> prefix [
	^ #XMIATest
]

{ #category : #testing }
XMIAnalyzerTestGenerator class >> shouldBeUpToDateInLatestMoose [
	^ false
]

{ #category : #accessing }
XMIAnalyzerTestGenerator class >> submetamodels [
	^ {FamixGenerator}
]

{ #category : #definition }
XMIAnalyzerTestGenerator >> defineClasses [
	super defineClasses.

	class := builder newClassNamed: #Class.
	comment := builder newClassNamed: #Comment.
	enum := builder newClassNamed: #Enum.
	inheritance := builder newClassNamed: #Inheritance.
	package := builder newClassNamed: #Package.
]

{ #category : #definition }
XMIAnalyzerTestGenerator >> defineHierarchy [
	super defineHierarchy.

	class --|> #TClass.

	comment --|> #TComment.
	comment --|> #TWithComments.

	enum --|> #TWithEnumValues.
	enum --|> #TType.

	inheritance --|> #TInheritance.

	package --|> #TPackage.
	package --|> #TPackageable.
	package --|> #TWithTypes
]
