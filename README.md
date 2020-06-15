# **REPO MIGRATED TO https://github.com/moosetechnology/xmi-analyzer**

I no longer maintain this project, please follow the link above.

---

# XMI Analyzer
[![Build Status](https://travis-ci.org/peteruhnak/xmi-analyzer.svg?branch=master)](https://travis-ci.org/peteruhnak/xmi-analyzer) [![Coverage Status](https://coveralls.io/repos/github/peteruhnak/xmi-analyzer/badge.svg?branch=master)](https://coveralls.io/github/peteruhnak/xmi-analyzer?branch=master)

XMI Analyzer is a (prototype) utility assisting in analyzing XMI files.

Sponsored by [Synectique ![](http://synectique.eu/templates/st_orddie/images/logo.png)](http://synectique.eu/)


Note that XMI is a subset of XML with rather specific rulues.

* For free-form-ish XML you might be interested in https://github.com/peteruhnak/xml-magritte-generator
* For generic XMI see https://github.com/OpenPonk/xmi
	* this project should migrate to use that at some point


## Installation

```
Metacello new
	baseline: 'XMIAnalyzer';
	repository: 'github://peteruhnak/xmi-analyzer/repository';
	load.
```

Instead of operating on the DOM this tool will generate appropriate classes for the individual node types and will instantiate them from the XMI.

The instantiation includes:

* basic type inference (booleans, numbers, strings, IDREF(s))
* reference resolution
	* instead of having string IDs in the DOM, the instances will have proper object references

## Usage

```smalltalk
"get an instance of DOM tree"
"dom := XMLDOMParser parse: FileLocator home asFileReference / 'prog/xmi/examples/smr2.xml'."
dom := XMIAnalyzer sampleStateMachineXmi.

"Generate the necessary classes. Prefix will be added before all generated classes."
XMIAnalyzer createClassesFor: dom prefixed: 'SMX' in: 'MyGeneratedClasses'.

"Create the instances in the generated classes."
instance := XMIAnalyzer createInstanceOf: dom prefixed: 'SMX'.

"Inspect the instance"
instance inspect.

"Apply a simple Mondrian demo visualization (requires Roassal)"
(XMIAnalyzer sampleStateMachineVisualization: instance) open.
```

## Example

In-image example is available after running `XMIAnalyzer>>exampleStateMachineScenario`

Example usage on some XMI:

![Example usage](docs/example.png)

Original XMI

![Original XMI](docs/xml-tree.png)

Generated classes for the tree

![Generated classes](docs/classes.png)

Inspecting the instantiated model

![Inspecting XMI instance](docs/navigation.png)

Simple Roassal visualization of the content.

![Roassal visualization with Mondrian](docs/visualization.png)
