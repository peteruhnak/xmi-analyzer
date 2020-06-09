Class {
	#name : #XAAbstractGeneratorTest,
	#superclass : #XABaseTest,
	#instVars : [
		'generator'
	],
	#category : #'XMI-Analyzer-Tests'
}

{ #category : #accessing }
XAAbstractGeneratorTest >> generatorClass [
	^ self subclassResponsibility
]

{ #category : #'instance creation' }
XAAbstractGeneratorTest >> newElement: aName [
	^ self newElement: aName attributes: #()
]

{ #category : #'instance creation' }
XAAbstractGeneratorTest >> newElement: aName attributes: aCollection [
	^ self
		newElement: aName
		attributes: aCollection
		namespaces:
			{(#uml -> 'http://schema.omg.org/spec/UML/2.1').
			(#xmi -> 'http://schema.omg.org/spec/XMI/2.1')}
]

{ #category : #'instance creation' }
XAAbstractGeneratorTest >> newElement: aString attributes: attributes namespaces: namespaces [
	^ XMLElement name: aString namespaces: namespaces attributes: attributes
]

{ #category : #'instance creation' }
XAAbstractGeneratorTest >> newSimpleDom [
	<script: 'self new newSimpleDom inspect'>
	^ XMLDOMParser parse: '<xmi:XMI xmi:version="2.1" xmlns:uml="http://schema.omg.org/spec/UML/2.1" xmlns:xmi="http://schema.omg.org/spec/XMI/2.1" xmlns:thecustomprofile="http://www.sparxsystems.com/profiles/thecustomprofile/1.0">
	<packagedElement xmi:type="uml:Package" xmi:id="ID_0" name="State Machine Model" visibility="public">
		<subvertex xmi:type="uml:State" xmi:id="ID_1" name="State1" visibility="public" isSubmachineState="false">
			<incoming xmi:idref="ID_3"/>
		</subvertex>
		<transition xmi:type="uml:Transition" xmi:id="ID_3" visibility="public" kind="local" source="ID_2" target="ID_1"/>
		<subvertex xmi:type="uml:Pseudostate" xmi:id="ID_2" name="Initial" visibility="public" kind="initial">
			<outgoing xmi:idref="ID_3"/>
		</subvertex>
	</packagedElement>
</xmi:XMI>'
]

{ #category : #'instance creation' }
XAAbstractGeneratorTest >> newStructureDom [
	<script: 'self new newStructureDom inspect'>
	^ XMLDOMParser parse: '<xmi:XMI xmi:version="2.1" xmlns:uml="http://schema.omg.org/spec/UML/2.1" xmlns:xmi="http://schema.omg.org/spec/XMI/2.1" xmlns:thecustomprofile="http://www.sparxsystems.com/profiles/thecustomprofile/1.0">
	<packagedElement xmi:type="uml:Package" xmi:id="ID_0">
		<subvertex xmi:type="uml:State" xmi:id="ID_1">
			<incoming xmi:idref="ID_3"/>
		</subvertex>
		<transition xmi:type="uml:Transition" xmi:id="ID_3" source="ID_2" target="ID_1"/>
		<subvertex xmi:type="uml:Pseudostate" xmi:id="ID_2">
			<outgoing xmi:idref="ID_3"/>
		</subvertex>
	</packagedElement>
</xmi:XMI>'
]

{ #category : #running }
XAAbstractGeneratorTest >> setUp [
	super setUp.
	generator := self generatorClass new.
	generator classPrefix: self classPrefix.
	generator packageName: self packageName
]

{ #category : #running }
XAAbstractGeneratorTest >> tearDown [
	super tearDown.
	self cleanUpPackage
]
