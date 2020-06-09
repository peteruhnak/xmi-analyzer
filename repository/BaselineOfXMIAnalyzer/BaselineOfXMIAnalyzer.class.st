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
				package: 'XMI-Analyzer-Tests-Generator' with: [ spec requires: #('FamixGenerator') ];
				package: 'XMI-Analyzer-Tests-Entities' with: [ spec requires: #('Famix') ];
				package: 'XMI-Analyzer-Tests' with: [ spec requires: #('XMI-Analyzer' 'XMI-Analyzer-Tests-Entities') ].

			spec
				group: 'Core' with: #('XMI-Analyzer');
				group: 'Tests' with: #('XMI-Analyzer-Tests') ]
]

{ #category : #dependencies }
BaselineOfXMIAnalyzer >> famix: spec [
	spec
		baseline: 'Famix'
			with: [ spec
				loads: 'BasicTraits';
				repository: 'github://moosetechnology/Famix:development/src' ];
		project: 'FamixGenerator' copyFrom: 'Famix' with: [ spec loads: 'Basic' ]
]

{ #category : #dependencies }
BaselineOfXMIAnalyzer >> xmlDomVisitor: spec [
	spec baseline: 'XMLDOMVisitor' with: [ spec repository: 'github://OpenPonk/xml-dom-visitor/repository' ]
]
