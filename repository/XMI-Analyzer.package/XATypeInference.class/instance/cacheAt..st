accessing
cacheAt: elementName
	^ cache at: elementName asSymbol ifAbsentPut: [ Dictionary new ]