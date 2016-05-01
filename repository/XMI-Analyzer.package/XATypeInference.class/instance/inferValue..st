inference
inferValue: aString
	aString ifEmpty: [ ^ #EMPTY ].
	aString = 'true' | (aString = 'false')
		ifTrue: [ ^ #Boolean ].
	(NumberParser isNumber: aString)
		ifTrue: [ | num |
			num := NumberParser parse: aString.
			num isInteger
				ifTrue: [ ^ #Integer ].
			num isFloat
				ifTrue: [ ^ #Float ].
			^ #Number ].
	(idRefs includes: aString)
		ifTrue: [ ^ #IDREF ].
	((aString splitOn: ' ') allSatisfy: [ :each | idRefs includes: each ])
		ifTrue: [ ^ #IDREFS ].
	^ #String