tests
testDom
	| dom |
	dom := self newSimpleDom.
	self
		assert: (inference inferDocument: dom)
		equals:
			(Dictionary new
				add: #container -> (Dictionary with: #name -> #String with: #xmi:id -> #ID);
				add:
					#node
						->
							(Dictionary
								with: #name -> #String
								with: #property -> #Boolean
								with: #xmi:id -> #ID
								with: 'size' -> #Integer);
				add:
					#edge
						-> (Dictionary with: #source -> #IDREF with: #target -> #IDREFS with: #xmi:id -> #ID);
				add: #incoming -> (Dictionary with: #xmi:idref -> #IDREF);
				add: #outgoing -> (Dictionary with: #xmi:idref -> #IDREF);
				add: #xmi:XMI -> (Dictionary with: 'xmi:version' -> #Float);
				yourself)