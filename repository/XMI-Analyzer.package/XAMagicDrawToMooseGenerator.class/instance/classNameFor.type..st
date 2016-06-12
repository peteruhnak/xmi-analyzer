normalizing
classNameFor: anElementName type: aTypeName
	aTypeName = 'uml:Model'
		ifTrue: [ ^ #MooseModel ].
	aTypeName = 'uml:Package'
		ifTrue: [ ^ #FAMIXPackage ].
	aTypeName = 'uml:Comment'
		ifTrue: [ ^ #FAMIXComment ].
	aTypeName = 'uml:Enumeration'
		ifTrue: [ ^ #FAMIXEnum ].
	aTypeName = 'uml:Class'
		ifTrue: [ ^ #FAMIXClass ].
	aTypeName = 'uml:Generalization'
		ifTrue: [ ^ #FAMIXInheritance ].
	"There is no class for Dependency in FAMIX, so I will ignore it for now"
	aTypeName = 'uml:Dependency'
		ifTrue: [ ^ nil ].
	"We are not interested in attributes, associations and other things"
	aTypeName = 'uml:Property'
		ifTrue: [ ^ nil ].
	aTypeName = 'uml:Association'
		ifTrue: [ ^ nil ].
	1 halt.
	^ super classNameFor: anElementName type: aTypeName