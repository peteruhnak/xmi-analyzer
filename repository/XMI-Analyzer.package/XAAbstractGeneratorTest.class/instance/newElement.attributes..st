instance creation
newElement: aName attributes: aCollection
	^ self
		newElement: aName
		attributes: aCollection
		namespaces:
			{(#uml -> 'http://schema.omg.org/spec/UML/2.1').
			(#xmi -> 'http://schema.omg.org/spec/XMI/2.1')}