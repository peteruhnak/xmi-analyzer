normalizing
classNameFor: anElementName type: aTypeName
	| parts |
	parts := (aTypeName ifEmpty: [ anElementName ]) splitOn: ':'.
	self useTypeNamespace
		ifFalse: [ parts := {parts last} ].
	^ self classPrefix , ((parts collect: #capitalized) joinUsing: '')