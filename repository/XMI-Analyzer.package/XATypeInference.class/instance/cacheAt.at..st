accessing
cacheAt: elementName at: attributeKey
	^ (cache at: elementName asSymbol ifAbsentPut: [ Dictionary new ])
		at: attributeKey asSymbol
		ifAbsentPut: [ #EMPTY ]