Extension { #name : #FamixTPackage }

{ #category : #'*XMI-Analyzer' }
FamixTPackage >> accept: aVisitor [
	aVisitor visitPackage: self
]
