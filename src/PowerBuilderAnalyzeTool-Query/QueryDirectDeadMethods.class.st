Class {
	#name : #QueryDirectDeadMethods,
	#superclass : #AbstractPWBQuery,
	#category : #'PowerBuilderAnalyzeTool-Query'
}

{ #category : #running }
QueryDirectDeadMethods >> runOn: aCollection [
	| result |
	result := aCollection
		select: [ :m | 
			({FamixPWBEvent.
			FamixPWBTrigger} includes: m class) not
				and: [ m incomingInvocations isEmpty and: [ m isNoisyMethod not ] ] ].
	result do: [ :method | method isPWBDead: true ].
	^ result
]
