Extension { #name : #FamixTClass }

{ #category : #'*XMI-Analyzer' }
FamixTClass >> accept: aVisitor [
	aVisitor visitClass: self
]
