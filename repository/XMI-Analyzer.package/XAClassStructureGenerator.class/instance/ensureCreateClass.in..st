code generation
ensureCreateClass: aName in: aPackage
	^ classes
		at: aName
		ifAbsentPut: [ XADelayedClass name: aName parent: Object package: aPackage ]