normalizing
classNameFor: anElementName type: aTypeName
	^ (Dictionary new
		at: 'uml:Model' put: #MooseModel;
		at: 'uml:Package' put: #FAMIXPackage;
		at: 'uml:Comment' put: #FAMIXComment;
		at: 'uml:Enumeration' put: #FAMIXEnum;
		at: 'uml:Class' put: #FAMIXClass;
		at: 'uml:Generalization' put: #FAMIXInheritance;
		"currently we do not take into account uml:dependency"
		at: 'uml:Dependency' put: nil;
		"We are not interested in attributes, associations and other things"
			at: 'uml:Property' put: nil;
		at: 'uml:Association' put: nil;
		yourself)
		at: aTypeName
		ifAbsent: [ 	super classNameFor: anElementName type: aTypeName ]