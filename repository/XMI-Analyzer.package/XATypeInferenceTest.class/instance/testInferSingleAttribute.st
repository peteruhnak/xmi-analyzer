tests
testInferSingleAttribute
	| el |
	el := XMLElement name: 'element' attributes: {(#key -> 'value')}.
	self assert: (inference inferAttribute: el attributeNodes first) equals: #String