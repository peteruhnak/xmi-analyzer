tests
testSetup
	self assert: delayedClass realClass equals: nil.
	self assert: delayedClass name equals: self classPrefix , 'Delayed'.
	self assert: delayedClass parent equals: Object.
	self assert: delayedClass package equals: self packageName.
	self assert: delayedClass instanceVariables asArray equals: #()