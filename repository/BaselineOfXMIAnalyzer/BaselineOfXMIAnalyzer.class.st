"
I am a baseline for https://github.com/peteruhnak/xmi-analyzer
"
Class {
	#name : #BaselineOfXMIAnalyzer,
	#superclass : #BaselineOf,
	#category : #BaselineOfXMIAnalyzer
}

{ #category : #baselines }
BaselineOfXMIAnalyzer >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ self
				xmlDomVisitor: spec;
				famix: spec.

			spec
				package: 'XMI-Analyzer' with: [ spec requires: #('XMLDOMVisitor' 'Famix') ];
				package: 'XMI-Analyzer-Tests' with: [ spec requires: #('XMI-Analyzer') ].

			spec
				group: 'Core' with: #('XMI-Analyzer');
				group: 'Tests' with: #('XMI-Analyzer-Tests') ]
]

{ #category : #dependencies }
BaselineOfXMIAnalyzer >> famix: spec [
	spec
		project: 'Famix'
		with: [ spec
				className: #ConfigurationOfFamix;
				versionString: #stable;
				loads: #('Core');
				repository: 'http://smalltalkhub.com/mc/Moose/Famix/main/' ]
]

{ #category : #dependencies }
BaselineOfXMIAnalyzer >> xmlDomVisitor: spec [
	spec baseline: 'XMLDOMVisitor' with: [ spec repository: 'github://OpenPonk/xml-dom-visitor/repository' ]
]
