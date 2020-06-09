Extension { #name : #FamixTType }

{ #category : #'*XMI-Analyzer' }
FamixTType >> accept: aVisitor [
	aVisitor visitType: self
]
