instantiating
addReference: aChild to: aParent at: aName
	"Here a message mapping should be defined how the children should be added to the parents.

In XMI normally the parent element has an attribute with the name of the child element, e.g.

<uml:Model xmi:type='uml:Model' xmi:id='id_0' name='Model0'>
	<packagedElement xmi:type='uml:Package' xmi:id='pkg_1' name='PKG1'>
</uml:Model>

So a Model would have an attribute called 'packagedElement' that would have a collection of packagedElements.

In Moose however, the relationships are different, so you must say in what way.

E.g. you can just do aMooseModel add: aFAMIXPackage. However for other parts attributes are needed. XMI/UML and FAMIX do not have the same model, so its a bit tricky."

	((aParent isKindOf: MooseModel) and: [ aChild isKindOf: FAMIXPackage ])
		ifTrue: [ ^ aParent add: aChild ].
	"I don't know how packages inside packages are represented in Moose, there is FAMIXPackageGroup, but that cannot have FAMIXComments..."
	((aParent isKindOf: FAMIXPackage) and: [ aChild isKindOf: FAMIXPackage ])
		ifTrue: [ ^ aParent mooseModel add: aChild ].
	((aParent isKindOf: FAMIXPackage) and: [ aChild isKindOf: FAMIXType ])
		ifTrue: [ ^ aParent addType: aChild ].
	"The owner of a Generalization is the child"
	((aChild isKindOf: FAMIXInheritance) and: [ aName = #generalization ])
		ifTrue: [ ^ aParent addSuperInheritance: aChild ].

	"Any FAMIXSourcedEntity can have comments"
	aName = #ownedComment
		ifTrue: [ ^ aParent addComment: aChild ].
	"A Comment in UML has an owner (#ownedComment) and an annotatedElement, but I don't remember the exact mechanics of who the comment is actually commenting... please refer to the specs, here I will just use ownedComment and ignore annotatedElement"
	aName = #annotatedElement
		ifTrue: [ ^ self ].
	1 halt