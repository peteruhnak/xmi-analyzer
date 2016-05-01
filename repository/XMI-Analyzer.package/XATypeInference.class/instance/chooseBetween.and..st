as yet unclassified
chooseBetween: oneType and: secondType
	| types |
	types := Set with: oneType with: secondType.
	types size = 1
		ifTrue: [ ^ types anyOne ].
	(types includes: #String)
		ifTrue: [ ^ #String ].
	(types includes: #EMPTY)
		ifTrue: [ ^ types detect: [ :each | (each = #EMPTY) not ] ].
	(types includes: #Integer)
		ifTrue: [ ^ types detect: [ :each | (each = #Integer) not ] ].
	(types includes: #IDREF) & (types includes: #IDREFS)
		ifTrue: [ ^ #IDREFS ].
	self error: 'Unhandled case'