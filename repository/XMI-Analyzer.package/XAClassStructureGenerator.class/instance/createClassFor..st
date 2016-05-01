xml processing
createClassFor: anElement
	| cls |
	cls := self ensureCreateClass: (self classNameFor: anElement) in: self packageName.
	self createAttributesFor: anElement in: cls