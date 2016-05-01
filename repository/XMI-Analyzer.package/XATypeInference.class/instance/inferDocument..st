inference
inferDocument: aDocument
	idRefs := self collectIdsFrom: aDocument.
	(visitor := XATypeInferenceVisitor new) collector: self.
	visitor visit: aDocument.
	^ cache