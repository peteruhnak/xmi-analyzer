as yet unclassified
testTypes
	self assert:  mooseModel allTypes size equals: 6.
	self assert: mooseModel allTypes first container name equals: 'NIVEAU1'.
	self assert: mooseModel allTypes second container name equals: 'BSL1'