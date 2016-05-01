instantiating
createInstanceFor: anElement class: aClass
	| instance |
	instance := aClass new.
	self setXmiAttributesFrom: anElement to: instance.
	self setAttributesFrom: anElement to: instance.
	instances ifEmpty: [ topInstance := instance ].
	instances at: anElement put: instance.
	self resolveReference: anElement.
	^ instance