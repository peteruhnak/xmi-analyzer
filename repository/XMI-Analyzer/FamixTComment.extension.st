Extension { #name : #FamixTComment }

{ #category : #'*XMI-Analyzer' }
FamixTComment >> accept: aVisitor [
	aVisitor visitComment: self
]
