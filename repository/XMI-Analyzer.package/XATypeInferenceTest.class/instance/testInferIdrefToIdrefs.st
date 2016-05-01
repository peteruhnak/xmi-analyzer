tests
testInferIdrefToIdrefs
	| el el2 |
	inference idRefs: #(#ID_1 #ID_2).
	el := XMLElement name: 'element' attributes: {(#key -> 'ID_1')}.
	el2 := XMLElement name: 'element' attributes: {(#key -> 'ID_1 ID_2')}.
	self assert: (inference inferAttribute: el attributeNodes first) equals: #IDREF.
	self assert: (inference inferAttribute: el2 attributeNodes first) equals: #IDREFS