tests
testCollectIds
	| ids |
	ids := generator collectIdsFrom: self newSimpleDom.
	self assert: (ids collect: #key) asSet equals: #(#ID_0 #ID_1 #ID_2 #ID_3) asSet