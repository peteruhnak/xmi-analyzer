Extension { #name : #MooseModel }

{ #category : #'*XMI-Analyzer' }
MooseModel >> accept: aVisitor [
	aVisitor visitModel: self
]
