"
I am the entrypoint for XMI Analysis.

!! Examples

See class-side for examples.
"
Class {
	#name : #XMIAnalyzer,
	#superclass : #Object,
	#category : 'XMI-Analyzer-Core'
}

{ #category : #'public API' }
XMIAnalyzer class >> createClassesFor: aDom prefixed: aPrefix in: aPackage [
	XACodeGeneratingVisitor new
		classPrefix: aPrefix;
		packageName: aPackage;
		visit: aDom
]

{ #category : #'public API' }
XMIAnalyzer class >> createInstanceOf: aDom prefixed: aPrefix [
	^ XAInstanceGeneratingVisitor new
		classPrefix: aPrefix;
		visit: aDom
]

{ #category : #examples }
XMIAnalyzer class >> exampleStateMachineScenario [
	^ (GTPlayground
		openContents:
			(((self class >> #sampleStateMachineScenario) sourceCode lines allButFirst: 2)
				joinUsing: String cr)
		label: 'Sample State Machine Scenario') window
		title: 'PL @ Sample State Machine Scenario'
]

{ #category : #examples }
XMIAnalyzer class >> sampleStateMachineScenario [
|dom instance|
"dom := XMLDOMParser parse: FileLocator home asFileReference / 'prog/xmi/examples/smr2.xml'."
dom := XMIAnalyzer sampleStateMachineXmi.

"Generate the necessary classes. Prefix will be added before all generated classe."
XMIAnalyzer createClassesFor: dom prefixed: 'SMX' in: 'MyGeneratedClasses'.

"Create the instances in the generated classes."
instance := XMIAnalyzer createInstanceOf: dom prefixed: 'SMX'.

"Inspect the instance"
instance inspect.

"Apply a simple Mondrian demo visualization (requires Roassal)"
(XMIAnalyzer sampleStateMachineVisualization: instance) ifNotNil: #open.
]

{ #category : #examples }
XMIAnalyzer class >> sampleStateMachineVisualization: aModel [
"a SMXModel"
| m fullName shape shapeLabel shapeNoText regionNest vertexNest smNest pkgNest modelNest |
	(Smalltalk hasClassNamed: #RTMondrian) ifFalse: [
		self inform: 'RTMondrian is not available. Install Roassal2 from the catalog.'.
		^ nil
	].
	m := RTMondrian new.
	fullName := [ :each | each name , '[' , (each className withoutPrefix: 'SMX') , ']' ].
	shape := [ :color | 
	m shape box
		color: color veryMuchLighter;
		borderColor: color;
		withTextAbove: [ :each | fullName value: each ];
		withTextColor: color ].
	shapeLabel := [ :color | 
	m shape label color: color.
	m interaction removeInteractionOfType: RTAbstractDraggable ].
	shapeNoText := [ :color | 
	m shape box
		color: color veryMuchLighter;
		borderColor: color ].
	vertexNest := [ :vertex | 
	shapeLabel value: Color black.
	m nodes: {(fullName value: vertex)}.
	shapeNoText value: Color blue.
	((vertex respondsTo: #region) and: [ vertex region isNotNil ])
		ifTrue: [ m nodes: vertex region forEach: regionNest.
			m layout verticalLine ] ].
	regionNest := [ :region | 
	shapeLabel value: Color blue.
	m nodes: {(fullName value: region)}.
	shapeNoText value: Color black.
	m nodes: (region subvertex ifNil: [ #() ]) forEach: vertexNest.
	m edges shape arrowedLine.
	m edges
		useAssociations:
			((region transition ifNil: [ #() ])
				collect: [ :each | each source -> each target ]).
	m layout horizontalTree ].
	smNest := [ :sm | 
	shapeNoText value: Color blue.
	m nodes: sm region forEach: regionNest ].
	pkgNest := [ :pkg | 
	shape value: Color black.
	m
		nodes: (pkg packagedElement select: [ :each | each isKindOf: #SMXStateMachine asClass ])
		forEach: smNest ].
	modelNest := [ :model | 
	shape value: Color green.
	m nodes: model packagedElement forEach: pkgNest ].
	shape value: Color red.
	m nodes: {aModel} forEach: modelNest.
	m build.
	m view @ RTZoomableView.
	^ m
]

{ #category : #examples }
XMIAnalyzer class >> sampleStateMachineXmi [
	<script: 'self sampleStateMachineXmi inspect'>
	^ XMLDOMParser
		parse:
			'<?xml version="1.0" encoding="windows-1252"?>
<xmi:XMI xmi:version="2.1" xmlns:uml="http://schema.omg.org/spec/UML/2.1" xmlns:xmi="http://schema.omg.org/spec/XMI/2.1" xmlns:thecustomprofile="http://www.sparxsystems.com/profiles/thecustomprofile/1.0">
	<xmi:Documentation exporter="Enterprise Architect" exporterVersion="6.5"/>
	<uml:Model xmi:type="uml:Model" name="EA_Model" visibility="public">
		<packagedElement xmi:type="uml:Package" xmi:id="ID_1" name="State Machine Model" visibility="public">
			<packagedElement xmi:type="uml:StateMachine" xmi:id="ID_2" name="EA_StateMachine1" visibility="public">
				<region xmi:type="uml:Region" xmi:id="ID_3" name="EA_Region1" visibility="public">
					<subvertex xmi:type="uml:State" xmi:id="ID_4" name="Composite Shape" visibility="public" isSubmachineState="false">
						<incoming xmi:idref="ID_5"/>
						<outgoing xmi:idref="ID_6"/>
						<region xmi:type="uml:Region" xmi:id="ID_7" name="up" visibility="public">
							<subvertex xmi:type="uml:State" xmi:id="ID_14" name="SubState Up" visibility="public" isSubmachineState="false">
								<incoming xmi:idref="ID_15"/>
								<outgoing xmi:idref="ID_16"/>
							</subvertex>
							<transition xmi:type="uml:Transition" xmi:id="ID_16" visibility="public" kind="local" source="ID_14" target="ID_17">
								<trigger xmi:idref="ID_18"/>
								<guard xmi:type="uml:Constraint" xmi:id="ID_19">
									<specification xmi:type="uml:OpaqueExpression" xmi:id="ID_20" body="someGuard"/>
								</guard>
							</transition>
							<transition xmi:type="uml:Transition" xmi:id="ID_15" visibility="public" kind="local" source="ID_24" target="ID_14"/>
							<subvertex xmi:type="uml:Pseudostate" xmi:id="ID_24" name="Initial Up" visibility="public" kind="initial">
								<outgoing xmi:idref="ID_15"/>
							</subvertex>
							<subvertex xmi:type="uml:State" xmi:id="ID_17" name="Substate Up 2" visibility="public" isSubmachineState="false">
								<incoming xmi:idref="ID_16"/>
								<outgoing xmi:idref="ID_21"/>
							</subvertex>
							<transition xmi:type="uml:Transition" xmi:id="ID_21" visibility="public" kind="local" source="ID_17" target="ID_22"/>
							<subvertex xmi:type="uml:FinalState" xmi:id="ID_22" name="Final Up" visibility="public">
								<incoming xmi:idref="ID_21"/>
							</subvertex>
						</region>
						<region xmi:type="uml:Region" xmi:id="ID_8" name="down" visibility="public">
							<subvertex xmi:type="uml:State" xmi:id="ID_10" name="SubState Down" visibility="public" isSubmachineState="false">
								<incoming xmi:idref="ID_11"/>
								<outgoing xmi:idref="ID_12"/>
							</subvertex>
							<transition xmi:type="uml:Transition" xmi:id="ID_12" visibility="public" kind="local" source="ID_10" target="ID_13"/>
							<subvertex xmi:type="uml:FinalState" xmi:id="ID_13" name="Final Down" visibility="public">
								<incoming xmi:idref="ID_12"/>
							</subvertex>
							<subvertex xmi:type="uml:Pseudostate" xmi:id="ID_23" name="Initial Down" visibility="public" kind="initial">
								<outgoing xmi:idref="ID_11"/>
							</subvertex>
							<transition xmi:type="uml:Transition" xmi:id="ID_11" visibility="public" kind="local" source="ID_23" target="ID_10"/>
						</region>
						<connectionPoint xmi:type="uml:Pseudostate" xmi:id="ID_25" name="EntryPoint1" visibility="public" kind="entryPoint"/>
					</subvertex>
					<transition xmi:type="uml:Transition" xmi:id="ID_6" visibility="public" kind="local" source="ID_4" target="ID_26"/>
					<subvertex xmi:type="uml:State" xmi:id="ID_27" name="Less" visibility="public" isSubmachineState="false">
						<incoming xmi:idref="ID_28"/>
						<outgoing xmi:idref="ID_29"/>
					</subvertex>
					<transition xmi:type="uml:Transition" xmi:id="ID_29" visibility="public" kind="local" source="ID_27" target="ID_30"/>
					<subvertex xmi:type="uml:State" xmi:id="ID_31" name="More" visibility="public" isSubmachineState="false">
						<incoming xmi:idref="ID_32"/>
						<outgoing xmi:idref="ID_33"/>
					</subvertex>
					<transition xmi:type="uml:Transition" xmi:id="ID_33" visibility="public" kind="local" source="ID_31" target="ID_30"/>
					<subvertex xmi:type="uml:Pseudostate" xmi:id="ID_26" name="Choice" visibility="public" kind="choice">
						<incoming xmi:idref="ID_6"/>
						<outgoing xmi:idref="ID_28"/>
						<outgoing xmi:idref="ID_32"/>
					</subvertex>
					<transition xmi:type="uml:Transition" xmi:id="ID_32" visibility="public" kind="local" source="ID_26" target="ID_31">
						<guard xmi:type="uml:Constraint" xmi:id="ID_47">
							<specification xmi:type="uml:OpaqueExpression" xmi:id="ID_48" body="x &gt;= 5"/>
						</guard>
					</transition>
					<transition xmi:type="uml:Transition" xmi:id="ID_28" visibility="public" kind="local" source="ID_26" target="ID_27">
						<guard xmi:type="uml:Constraint" xmi:id="ID_49">
							<specification xmi:type="uml:OpaqueExpression" xmi:id="ID_50" body="x &lt; 5"/>
						</guard>
					</transition>
					<subvertex xmi:type="uml:FinalState" xmi:id="ID_30" name="Final" visibility="public">
						<incoming xmi:idref="ID_29"/>
						<incoming xmi:idref="ID_33"/>
					</subvertex>
					<subvertex xmi:type="uml:Pseudostate" xmi:id="ID_51" name="Initial" visibility="public" kind="initial">
						<outgoing xmi:idref="ID_5"/>
					</subvertex>
					<transition xmi:type="uml:Transition" xmi:id="ID_5" visibility="public" kind="local" source="ID_51" target="ID_4"/>
				</region>
			</packagedElement>
			<packagedElement xmi:type="uml:Trigger" xmi:id="ID_18" name="trigger" visibility="public">
				<event xmi:type="uml:Event" xmi:id="ID_53"/>
			</packagedElement>
		</packagedElement>
	</uml:Model>
</xmi:XMI>'
]
