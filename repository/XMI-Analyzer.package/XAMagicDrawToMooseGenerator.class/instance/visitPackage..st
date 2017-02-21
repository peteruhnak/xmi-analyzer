visiting
visitPackage: aPackage
	 aPackage name: self elementName.
	(parent class = MooseModel) 
		ifFalse: [
			aPackage mooseModel: parent mooseModel. 
			parent addChildNamedEntity: aPackage.
			]
		ifTrue: [ aPackage mooseModel: parent ]