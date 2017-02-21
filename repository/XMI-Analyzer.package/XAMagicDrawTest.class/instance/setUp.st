as yet unclassified
setUp
	| dom umlModel visitor |
	dom := XMLDOMParser parse: self magicDrawExample.
	umlModel := dom root elements second.	"selecting just the <uml:Model> node with its children"
	visitor := XAInstanceGeneratingVisitor new.
	visitor generator: XAMagicDrawToMooseGenerator new.
	visitor generator inferTypesIn: umlModel.
	visitor classPrefix: ''.
	visitor visit: umlModel.
	visitor generator resolveReferences.
	mooseModel := visitor generator topInstance