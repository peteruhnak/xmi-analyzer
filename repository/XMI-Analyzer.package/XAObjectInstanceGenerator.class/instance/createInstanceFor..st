instantiating
createInstanceFor: anElement
	^ self createInstanceFor: anElement class: (self classNameFor: anElement) asClass