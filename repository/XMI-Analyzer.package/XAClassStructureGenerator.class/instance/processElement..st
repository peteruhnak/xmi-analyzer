xml processing
processElement: anElement
	(self isReferenceOnly: anElement)
		ifFalse: [ self createClassFor: anElement.
			self
				ensureAttributeWithAccessor: self ownerReference
				in: (self classFor: (self classNameFor: anElement)) ].
	(self hasParent: anElement)
		ifTrue: [ self
				ensureAttributeWithAccessor: anElement name
				in: (self classFor: (self classNameFor: anElement parent)) ]