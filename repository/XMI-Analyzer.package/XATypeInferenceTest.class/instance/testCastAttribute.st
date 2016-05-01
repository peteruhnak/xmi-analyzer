tests
testCastAttribute
	| el |
	el := XMLElement
		name: 'element'
		attributes: (Array with: #prop -> 'false' with: #num -> '12' with: #name -> 'str').
	inference inferElement: el.
	self assert: (inference castAttribute: el attributeNodes first) equals: false.
	self assert: (inference castAttribute: el attributeNodes second) equals: 12.
	self assert: (inference castAttribute: el attributeNodes third) equals: 'str'