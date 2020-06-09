Class {
	#name : #XAGeneratingVisitorTest,
	#superclass : #XABaseTest,
	#instVars : [
		'visitor'
	],
	#category : #'XMI-Analyzer-Tests'
}

{ #category : #'instance creation' }
XAGeneratingVisitorTest >> newSimpleDom [
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

{ #category : #running }
XAGeneratingVisitorTest >> setUp [
	super setUp.
	(visitor := self visitorClass new)
		packageName: self packageName;
		useTypeNamespace: false;
		classPrefix: self classPrefix
]

{ #category : #running }
XAGeneratingVisitorTest >> tearDown [
	super tearDown.
	self cleanUpPackage
]

{ #category : #accessing }
XAGeneratingVisitorTest >> visitorClass [
	^ self subclassResponsibility
]
