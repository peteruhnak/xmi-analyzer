Extension { #name : #FamixTInheritance }

{ #category : #'*XMI-Analyzer' }
FamixTInheritance >> accept: aVisitor [
	aVisitor visitInheritance: self
]
