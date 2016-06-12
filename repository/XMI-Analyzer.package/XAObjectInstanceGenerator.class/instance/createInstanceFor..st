instantiating
createInstanceFor: anElement
	| name |
	name := self classNameFor: anElement.
	name ifNil: [ ^ nil ].
	^ self createInstanceFor: anElement class: name asClass