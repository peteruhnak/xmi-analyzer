initialization
initialize
	super initialize.
	ids := Dictionary new.
	inference := XATypeInference new.
	instances := Dictionary new.
	unresolved := OrderedCollection new