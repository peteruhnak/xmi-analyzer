as yet unclassified
testComments
	self assert:  mooseModel allPackages first comments size > 0 description: 'No Packages found in MooseModel'.
	self assert: mooseModel allPackages first comments first content size > 0 description: 'Comment cannot be empty'