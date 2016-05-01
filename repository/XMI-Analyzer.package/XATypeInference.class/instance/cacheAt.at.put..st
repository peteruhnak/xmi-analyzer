accessing
cacheAt: elementName at: attributeKey put: aValue
	^ (cache at: elementName asSymbol ifAbsentPut: [ Dictionary new ])
		at: attributeKey asSymbol
		put: aValue