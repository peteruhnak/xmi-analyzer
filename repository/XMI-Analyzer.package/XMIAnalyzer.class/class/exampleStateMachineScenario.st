examples
exampleStateMachineScenario
	^ (GTPlayground
		openContents:
			(((self class >> #sampleStateMachineScenario) sourceCode lines allButFirst: 2)
				joinUsing: String cr)
		label: 'Sample State Machine Scenario') window
		title: 'PL @ Sample State Machine Scenario'