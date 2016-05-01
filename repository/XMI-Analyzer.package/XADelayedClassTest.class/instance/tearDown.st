running
tearDown
	delayedClass realClass ifNotNil: [ :cls | cls removeFromSystem ]