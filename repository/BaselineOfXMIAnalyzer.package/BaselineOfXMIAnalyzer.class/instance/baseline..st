baselines
baseline: spec
	<baseline>
	spec
		for: #common
		do: [ self
				xmlDomVisitor: spec;
				famix: spec.
			spec package: 'XMI-Analyzer' with: [ spec requires: #('XMLDOMVisitor' 'Famix') ].
			spec group: 'default' with: #('XMI-Analyzer') ]