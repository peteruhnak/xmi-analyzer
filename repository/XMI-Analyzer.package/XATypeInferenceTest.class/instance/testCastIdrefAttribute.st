tests
testCastIdrefAttribute
	| el |
	el := XMLElement
		name: 'element'
		attributes: (Array with: #refs -> 'ID_1 ID_2' with: #ref -> 'ID_1').
	inference idRefs: #(#ID_1 #ID_2).
	inference inferElement: el.
	self assert: (inference castAttribute: el attributeNodes first) equals: #('ID_1' 'ID_2').
	self assert: (inference castAttribute: el attributeNodes second) equals: 'ID_1'