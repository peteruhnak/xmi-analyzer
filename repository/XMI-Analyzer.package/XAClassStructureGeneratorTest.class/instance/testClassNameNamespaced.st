tests
testClassNameNamespaced
	generator classPrefix: ''.
	generator useTypeNamespace: true.
	self assert: (generator classNameFor: 'tagName' type: '') equals: 'TagName'.
	self assert: (generator classNameFor: 'tagName' type: 'uml:TagName') equals: 'UmlTagName'.
	self assert: (generator classNameFor: 'tag:name' type: '') equals: 'TagName'