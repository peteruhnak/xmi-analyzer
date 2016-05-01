inference
inferAttribute: anAttribute
	| type previous newType |
	type := anAttribute name = #xmi:id
		ifTrue: [ #ID ]
		ifFalse: [ self inferValue: anAttribute value ].
	previous := self cacheAt: anAttribute element name at: anAttribute name.
	newType := self chooseBetween: type and: previous.
	self cacheAt: anAttribute element name at: anAttribute name put: newType.
	^ newType