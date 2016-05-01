tests
testInferDowngrade
	| el el2 |
	el := XMLElement name: 'element' attributes: {(#key -> 'hello')}.
	el2 := XMLElement name: 'element' attributes: {(#key -> '12')}.
	self assert: (inference inferAttribute: el attributeNodes first) equals: #String.
	self assert: (inference inferAttribute: el2 attributeNodes first) equals: #String