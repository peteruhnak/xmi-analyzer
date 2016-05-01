tests
testClassName
	generator classPrefix: ''.
	self assert: (generator classNameFor: 'tagName' type: '') equals: 'TagName'.
	self assert: (generator classNameFor: 'tagName' type: 'uml:TagName') equals: 'TagName'.
	self assert: (generator classNameFor: 'tag:name' type: '') equals: 'Name'