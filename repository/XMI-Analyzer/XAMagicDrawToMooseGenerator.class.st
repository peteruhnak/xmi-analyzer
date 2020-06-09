"
Extracts UML description from XMI exported from Magic draw and creates a moose model for these entities.
"
Class {
	#name : #XAMagicDrawToMooseGenerator,
	#superclass : #XAObjectInstanceGenerator,
	#instVars : [
		'node',
		'parent',
		'currentElement',
		'factory'
	],
	#category : #'XMI-Analyzer-Core'
}

{ #category : #example }
XAMagicDrawToMooseGenerator class >> example [
	| dom model visitor |
	dom := XMLDOMParser parse: FileLocator home asFileReference / 'prog/synectique/nck_Niveau_1.xmi'.
	model := dom root elements second.

	visitor := XAInstanceGeneratingVisitor new.
	visitor generator: (self factory: FamixTest1Model factory).
	visitor generator inferTypesIn: model.
	visitor classPrefix: ''.
	visitor visit: dom root elements second.
	visitor generator resolveReferences.
	model := visitor generator topInstance
]

{ #category : #initialize }
XAMagicDrawToMooseGenerator class >> factory: aFMMetamodelFactory [
	^ self new
		factory: aFMMetamodelFactory;
		yourself
]

{ #category : #instantiating }
XAMagicDrawToMooseGenerator >> addReference: aChild to: aParent at: aName [
	"Here a message mapping should be defined how the children should be added to the parents.

In XMI normally the parent element has an attribute with the name of the child element, e.g.

<uml:Model xmi:type='uml:Model' xmi:id='id_0' name='Model0'>
	<packagedElement xmi:type='uml:Package' xmi:id='pkg_1' name='PKG1'>
</uml:Model>

So a Model would have an attribute called 'packagedElement' that would have a collection of packagedElements.

In Moose however, the relationships are different, so you must say in what way.

E.g. you can just do aMooseModel add: aFAMIXPackage. However for other parts attributes are needed. XMI/UML and FAMIX do not have the same model, so its a bit tricky."

	node accept: self.
	"I don't know how packages inside packages are represented in Moose, there is FAMIXPackageGroup, but that cannot have FAMIXComments..."
	"((aParent isKindOf: FAMIXPackage) and: [ aChild isKindOf: FAMIXPackage ])
		ifTrue: [ ^ aParent mooseModel add: aChild ].
	((aParent isKindOf: FAMIXPackage) and: [ aChild isKindOf: FAMIXType ])
		ifTrue: [ ^ aParent addType: aChild ]."
	"The owner of a Generalization is the child"
	"((aChild isKindOf: FAMIXInheritance) and: [ aName = #generalization ])
		ifTrue: [ ^ aParent addSuperInheritance: aChild ].
	(aChild isKindOf: FAMIXReference)
		ifTrue: [ ^ aParent addSuperInheritance: aChild ]."

	"Any FAMIXSourcedEntity can have comments"
	"aName = #ownedComment
		ifTrue: [ ^ aParent addComment: aChild ]."
	"A Comment in UML has an owner (#ownedComment) and an annotatedElement, but I don't remember the exact mechanics of who the comment is actually commenting... please refer to the specs, here I will just use ownedComment and ignore annotatedElement"
	"aName = #annotatedElement
		ifTrue: [ ^ self ].
	1 halt"
]

{ #category : #normalizing }
XAMagicDrawToMooseGenerator >> classNameFor: anElementName type: aTypeName [
	factory
		ifNil: [ self
				error:
					'This XMI generator needs to be configured with a metamodel factory. For example, if you generate a Famix smalltalk model you need to set `factory: FamixStModel factory`.' ].
	^ (Dictionary new
		at: 'uml:Model' put: factory modelClass name asSymbol;
		at: 'uml:Package' put: ((factory entityNamed: #Package ifAbsent: [ nil ]) ifNotNil: [ :c | c name asSymbol ]);
		at: 'uml:Comment' put: ((factory entityNamed: #Comment ifAbsent: [ nil ]) ifNotNil: [ :c | c name asSymbol ]);
		at: 'uml:Enumeration' put: ((factory entityNamed: #Enum ifAbsent: [ nil ]) ifNotNil: [ :c | c name asSymbol ]);
		at: 'uml:Class' put: ((factory entityNamed: #Class ifAbsent: [ nil ]) ifNotNil: [ :c | c name asSymbol ]);
		at: 'uml:Generalization' put: ((factory entityNamed: #Inheritance ifAbsent: [ nil ]) ifNotNil: [ :c | c name asSymbol ]);
		"currently we do not take into account uml:dependency"
			at: 'uml:Dependency' put: nil;
		"We are not interested in attributes, associations and other things"
			at: 'uml:Property' put: nil;
		at: 'uml:Association' put: nil;
		yourself) at: aTypeName ifAbsent: [ super classNameFor: anElementName type: aTypeName ]
]

{ #category : #instantiating }
XAMagicDrawToMooseGenerator >> elementName [
	^ currentElement attributeAt: 'name'
]

{ #category : #accessing }
XAMagicDrawToMooseGenerator >> factory: anObject [
	factory := anObject
]

{ #category : #instantiating }
XAMagicDrawToMooseGenerator >> resolveReference: anElement [
	anElement name = 'type'
		ifTrue: [ ^ self ].
	(anElement isRoot or: [ anElement parent isNil or: [ anElement parent isRoot ] ])
		ifTrue: [ ^ self ].
	parent := instances at: anElement parent.
	(anElement attributeAt: #xmi:idref)
		ifEmpty: [ node := instances at: anElement.
			currentElement := anElement.
			self addReference: node to: parent at: anElement name.
			self setReference: parent to: node at: self ownerReference ]
		ifNotEmpty: [ :idref | 
			unresolved
				add: [ self addReference: (instances at: (ids at: idref)) to: parent at: anElement name ] ]
]

{ #category : #instantiating }
XAMagicDrawToMooseGenerator >> setReference: aChild to: aParent at: aName [
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
]

{ #category : #instantiating }
XAMagicDrawToMooseGenerator >> setXmiAttributesFrom: anElement to: anInstance [
	"Moose uses numeric IDs, so I am not sure what should be the proper behavior here.. maybe a mapping table between MagicDraw IDs and Moose IDs"

	(anElement attributeAt: #xmi:id)
		ifNotEmpty: [ :id | anInstance instVarNamed: #mooseID put: id ]
]

{ #category : #visiting }
XAMagicDrawToMooseGenerator >> visitClass: aClass [
	self visitType: aClass
]

{ #category : #visiting }
XAMagicDrawToMooseGenerator >> visitComment: aComment [
	parent addComment: aComment.
	aComment mooseModel: parent mooseModel
]

{ #category : #visiting }
XAMagicDrawToMooseGenerator >> visitInheritance: aFamixInheritance [
	(parent addSuperInheritance: aFamixInheritance).
	aFamixInheritance mooseModel: parent mooseModel
]

{ #category : #visiting }
XAMagicDrawToMooseGenerator >> visitModel: aMooseModel [
	aMooseModel add: node
]

{ #category : #visiting }
XAMagicDrawToMooseGenerator >> visitPackage: aPackage [
	 aPackage name: self elementName.
	(parent isKindOf: MooseModel) 
		ifFalse: [
			aPackage mooseModel: parent mooseModel. 
			parent addChildEntity: aPackage.
			]
		ifTrue: [ aPackage mooseModel: parent ]
]

{ #category : #visiting }
XAMagicDrawToMooseGenerator >> visitType: aType [
	parent addType: aType.
	aType
		mooseModel: parent mooseModel;
		name: self elementName
]
