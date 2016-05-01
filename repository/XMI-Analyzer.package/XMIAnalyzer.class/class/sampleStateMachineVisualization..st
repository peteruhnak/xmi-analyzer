examples
sampleStateMachineVisualization: aModel
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