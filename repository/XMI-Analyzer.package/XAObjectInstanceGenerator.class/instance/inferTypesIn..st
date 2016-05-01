resolving
inferTypesIn: aDocument
	ids := (self collectIdsFrom: aDocument) asDictionary.
	inference := XATypeInference new.
	inference inferDocument: aDocument.
	^ inference