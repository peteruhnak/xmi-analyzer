testing
hasParent: anElement
	"The topmost root is not generated, so don't generate accessors there. Some tests also provide just a fragment of XML tree which would fail on missing parent."

	^ (anElement isRoot or: [ anElement parent isNotNil and: [ anElement parent isRoot ] ])
		not