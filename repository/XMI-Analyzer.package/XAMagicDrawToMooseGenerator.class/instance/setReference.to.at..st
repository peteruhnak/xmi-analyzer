instantiating
setReference: aChild to: aParent at: aName
	"Setting reference to MooseModel for a Package"

	"((aChild isKindOf: MooseModel) and: [ aParent isKindOf: FAMIXPackage ])
		ifTrue: [ ^ aParent mooseModel: aChild ].
	aName = #owner
		ifTrue: [ ^ aParent mooseModel: aChild mooseModel ]."
	aName = #body ifTrue: [ aParent content: aChild ].
	"Setting attributes of a Comment"
	"in XMI, the content is stored in 'body' attribute; in FAMIX in 'content'"
	"((aParent isKindOf: FAMIXComment) and: [ aName = #body ])
		ifTrue: [ ^ aParent content: aChild ]."
	"setting name"
	"((aParent isKindOf: FAMIXNamedEntity) | (aParent isKindOf: MooseModel) and: [ aName = #name ])
		ifTrue: [ ^ aParent name: aChild ]."
	"(aParent isKindOf: FAMIXInheritance)
		ifTrue: [ ^ aChild addSubInheritance: aParent ]."
	"1 halt"