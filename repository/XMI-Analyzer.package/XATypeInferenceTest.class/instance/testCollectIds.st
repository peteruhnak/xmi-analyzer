tests
testCollectIds
	| ids |
	ids := inference collectIdsFrom: self newSimpleDom.
	self assert: ids asSet equals: #(#ID_C_1 #ID_N_1 #ID_N_2 #ID_N_3 #ID_E_1 #ID_E_2) asSet