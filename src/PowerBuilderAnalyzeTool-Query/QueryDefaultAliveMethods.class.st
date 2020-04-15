Class {
	#name : #QueryDefaultAliveMethods,
	#superclass : #AbstractPWBQuery,
	#category : #'PowerBuilderAnalyzeTool-Query'
}

{ #category : #running }
QueryDefaultAliveMethods >> runOn: aCollection [
	^ aCollection
		select: [ :entity | 
			({FamixPWBEvent.
			FamixPWBTrigger} includes: entity class)
				or: [ entity isNoisyMethod ] ]
]
