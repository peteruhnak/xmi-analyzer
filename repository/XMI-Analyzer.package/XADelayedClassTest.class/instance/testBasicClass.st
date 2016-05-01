tests
testBasicClass
	| cls |
	cls := delayedClass save.
	self assert: delayedClass realClass equals: cls.
	self assert: cls className equals: self classPrefix , 'Delayed class'.
	self assert: cls superclass equals: Object.
	self assert: cls package name equals: self packageName.
	self assert: cls instanceVariables equals: #()