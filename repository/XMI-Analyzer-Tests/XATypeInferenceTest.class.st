Class {
	#name : #XATypeInferenceTest,
	#superclass : #XABaseTest,
	#instVars : [
		'inference',
		'result'
	],
	#category : #'XMI-Analyzer-Tests'
}

{ #category : #'instance creation' }
XATypeInferenceTest >> newSimpleDom [
	<script: 'self new newSimpleDom inspect'>
	^ XMLDOMParser
		parse:
			'<xmi:XMI xmi:version="2.1" xmlns:xmi="http://schema.omg.org/spec/XMI/2.1">
	<container xmi:id="ID_C_1" name="Container">
		<node xmi:id="ID_N_1" name="First Node" property="false">
			<outgoing xmi:idref="ID_E_1"/>
		</node>
		<node xmi:id="ID_N_2" name="First Node" property="true">
			<incoming xmi:idref="ID_E_1"/>
			<outgoing xmi:idref="ID_E_2"/>
		</node>
		<node xmi:id="ID_N_3" name="First Node" size="10">
			<incoming xmi:idref="ID_E_1"/>
			<incoming xmi:idref="ID_E_2"/>
		</node>
		<edge xmi:id="ID_E_1" source="ID_N_1" target="ID_N_2 ID_N_3"/>
		<edge xmi:id="ID_E_2" source="ID_N_2" target="ID_N_3"/>
	</container>
</xmi:XMI>'
]

{ #category : #running }
XATypeInferenceTest >> setUp [
	super setUp.
	inference := XATypeInference new
]

{ #category : #tests }
XATypeInferenceTest >> testCache [
	self assert: (inference cacheAt: #A at: #B) equals: #EMPTY.
	inference cacheAt: #A at: #B put: 42.
	self assert: (inference cacheAt: #A at: #B) equals: 42
]

{ #category : #tests }
XATypeInferenceTest >> testCastAttribute [
	| el |
	el := XMLElement
		name: 'element'
		attributes: (Array with: #prop -> 'false' with: #num -> '12' with: #name -> 'str').
	inference inferElement: el.
	self assert: (inference castAttribute: el attributeNodes first) equals: false.
	self assert: (inference castAttribute: el attributeNodes second) equals: 12.
	self assert: (inference castAttribute: el attributeNodes third) equals: 'str'
]

{ #category : #tests }
XATypeInferenceTest >> testCastIdrefAttribute [
	| el |
	el := XMLElement
		name: 'element'
		attributes: (Array with: #refs -> 'ID_1 ID_2' with: #ref -> 'ID_1').
	inference idRefs: #(#ID_1 #ID_2).
	inference inferElement: el.
	self assert: (inference castAttribute: el attributeNodes first) equals: #('ID_1' 'ID_2').
	self assert: (inference castAttribute: el attributeNodes second) equals: 'ID_1'
]

{ #category : #tests }
XATypeInferenceTest >> testChooseBetween [
	self assert: (inference chooseBetween: #String and: #String) equals: #String.
	self assert: (inference chooseBetween: #Integer and: #String) equals: #String.
	self assert: (inference chooseBetween: #EMPTY and: #String) equals: #String.
	self assert: (inference chooseBetween: #IDREF and: #IDREFS) equals: #IDREFS.
	self assert: (inference chooseBetween: #Integer and: #Number) equals: #Number.
	self assert: (inference chooseBetween: #Integer and: #Float) equals: #Float.
	self assert: (inference chooseBetween: #ID and: #ID) equals: #ID.
]

{ #category : #tests }
XATypeInferenceTest >> testCollectIds [
	| ids |
	ids := inference collectIdsFrom: self newSimpleDom.
	self assert: ids asSet equals: #(#ID_C_1 #ID_N_1 #ID_N_2 #ID_N_3 #ID_E_1 #ID_E_2) asSet
]

{ #category : #tests }
XATypeInferenceTest >> testDom [
	| dom |
	dom := self newSimpleDom.
	self
		assert: (inference inferDocument: dom)
		equals:
			(Dictionary new
				add: #container -> (Dictionary with: #name -> #String with: #xmi:id -> #ID);
				add:
					#node
						->
							(Dictionary
								with: #name -> #String
								with: #property -> #Boolean
								with: #xmi:id -> #ID
								with: 'size' -> #Integer);
				add:
					#edge
						-> (Dictionary with: #source -> #IDREF with: #target -> #IDREFS with: #xmi:id -> #ID);
				add: #incoming -> (Dictionary with: #xmi:idref -> #IDREF);
				add: #outgoing -> (Dictionary with: #xmi:idref -> #IDREF);
				add: #xmi:XMI -> (Dictionary with: 'xmi:version' -> #Float);
				yourself)
]

{ #category : #tests }
XATypeInferenceTest >> testElement [
	| element |
	element := XMLElement
		name: 'name'
		attributes: (Dictionary with: #name -> 'Str' with: #prop -> 'false').
	self
		assert: (inference inferElement: element)
		equals: (Dictionary with: #name -> #String with: #prop -> #Boolean)
]

{ #category : #tests }
XATypeInferenceTest >> testEmpty [
	self assert: (inference inferValue: '') equals: #EMPTY
]

{ #category : #tests }
XATypeInferenceTest >> testIdref [
	self assert: (inference inferValue: 'ID_1') equals: #String.
	inference idRefs: #(#ID_1).
	self assert: (inference inferValue: 'ID_1') equals: #IDREF
]

{ #category : #tests }
XATypeInferenceTest >> testIdrefs [
	self assert: (inference inferValue: 'ID_1 ID_2') equals: #String.
	inference idRefs: #(#ID_1 #ID_2).
	self assert: (inference inferValue: 'ID_1 ID_2') equals: #IDREFS
]

{ #category : #tests }
XATypeInferenceTest >> testInferBoolean [
	self assert: (inference inferValue: 'true') equals: #Boolean.
	self assert: (inference inferValue: 'false') equals: #Boolean
]

{ #category : #tests }
XATypeInferenceTest >> testInferDowngrade [
	| el el2 |
	el := XMLElement name: 'element' attributes: {(#key -> 'hello')}.
	el2 := XMLElement name: 'element' attributes: {(#key -> '12')}.
	self assert: (inference inferAttribute: el attributeNodes first) equals: #String.
	self assert: (inference inferAttribute: el2 attributeNodes first) equals: #String
]

{ #category : #tests }
XATypeInferenceTest >> testInferIdrefToIdrefs [
	| el el2 |
	inference idRefs: #(#ID_1 #ID_2).
	el := XMLElement name: 'element' attributes: {(#key -> 'ID_1')}.
	el2 := XMLElement name: 'element' attributes: {(#key -> 'ID_1 ID_2')}.
	self assert: (inference inferAttribute: el attributeNodes first) equals: #IDREF.
	self assert: (inference inferAttribute: el2 attributeNodes first) equals: #IDREFS
]

{ #category : #tests }
XATypeInferenceTest >> testInferNumber [
	self assert: (inference inferValue: '1') equals: #Integer.
	self assert: (inference inferValue: '1.2') equals: #Float
]

{ #category : #tests }
XATypeInferenceTest >> testInferSingleAttribute [
	| el |
	el := XMLElement name: 'element' attributes: {(#key -> 'value')}.
	self assert: (inference inferAttribute: el attributeNodes first) equals: #String
]

{ #category : #tests }
XATypeInferenceTest >> testInferString [
	self assert: (inference inferValue: 'ID_1') equals: #String.
	self assert: (inference inferValue: 'Name') equals: #String.
	self assert: (inference inferValue: 'public') equals: #String
]
