examples
sampleStateMachineScenario
|dom instance|
"dom := XMLDOMParser parse: FileLocator home asFileReference / 'prog/xmi/examples/smr2.xml'."
dom := XMIAnalyzer sampleStateMachineXmi.

"Generate the necessary classes. Prefix will be added before all generated classe."
XMIAnalyzer createClassesFor: dom prefixed: 'SMX' in: 'MyGeneratedClasses'.

"Create the instances in the generated classes."
instance := XMIAnalyzer createInstanceOf: dom prefixed: 'SMX'.

"Inspect the instance"
instance inspect.

"Apply a simple Mondrian demo visualization (requires Roassal)"
(XMIAnalyzer sampleStateMachineVisualization: instance) open.