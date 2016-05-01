tests
testOwnerReference
	self assert: generator ownerReference equals: 'owner'.
	generator ownerReference: 'ownerReference'.
	self assert: generator ownerReference equals: 'ownerReference'