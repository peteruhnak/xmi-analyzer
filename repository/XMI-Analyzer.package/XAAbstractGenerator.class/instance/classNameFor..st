normalizing
classNameFor: anElement
	^ self classNameFor: anElement name type: (anElement attributeAt: #xmi:type)