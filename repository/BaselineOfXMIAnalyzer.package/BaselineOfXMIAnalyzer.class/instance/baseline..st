as yet unclassified
baseline: spec
	<baseline>
	spec
		for: #common
		do: [ spec
				baseline: 'XMLDOMVisitor'
				with: [ spec repository: 'github://peteruhnak/xml-dom-visitor/repository' ].
			spec package: 'XMI-Analyzer' with: [ spec requires: #('XMLDOMVisitor') ].
			spec group: 'default' with: #('XMI-Analyzer') ]