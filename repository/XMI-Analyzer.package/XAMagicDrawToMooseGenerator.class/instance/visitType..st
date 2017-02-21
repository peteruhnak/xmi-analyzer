visiting
visitType: aType
	parent addType: aType.
	aType
		mooseModel: parent mooseModel;
		name: self elementName