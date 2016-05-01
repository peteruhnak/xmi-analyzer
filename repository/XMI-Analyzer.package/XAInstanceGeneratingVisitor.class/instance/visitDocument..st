visiting
visitDocument: aDocument
	generator inferTypesIn: aDocument.
	super visitDocument: aDocument.
	generator resolveReferences.
	instance := generator topInstance.
	^ instance