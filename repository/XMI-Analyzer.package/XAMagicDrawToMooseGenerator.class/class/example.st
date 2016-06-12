example
example
|dom model visitor|
dom := XMLDOMParser parse: FileLocator home asFileReference / 'prog/synectique/nck_Niveau_1.xmi'.
model := dom root elements second.

visitor := XAInstanceGeneratingVisitor new.
visitor generator: XAMagicDrawToMooseGenerator new.
visitor generator inferTypesIn: model.
visitor classPrefix: ''.
visitor visit: dom root elements second.
visitor generator resolveReferences.
model := visitor generator topInstance.