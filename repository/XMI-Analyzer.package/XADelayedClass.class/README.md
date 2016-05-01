I am a delayed class generation object to save some time during the code generation process, because of this:

```
Something removeFromSystem.
[
	cls := Object subclass: #Something instanceVariableNames: 'someVar otherVar'
] timeToRun humanReadablePrintString. "'120 milliseconds'"

Something removeFromSystem.
[
	cls := Object subclass: #Something.
	cls addInstVarNamed: 'someVar'.
	cls addInstVarNamed: 'otherVar'.
] timeToRun humanReadablePrintString. "'1 second 492 milliseconds'"
```