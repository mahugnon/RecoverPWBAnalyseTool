Class {
	#name : #QueryIncomingBetweenPWBObject,
	#superclass : #AbstractPWBQuery,
	#category : #'PowerBuilderAnalyzeTool-Query'
}

{ #category : #running }
QueryIncomingBetweenPWBObject >> runOn: aTarget with: aSource [
	| result |
	result := OrderedDictionary new.
	(aTarget methods reject: #isNoisyMethod) asSet
		do: [ :aMethod | 
			| senders |
			senders := aMethod incomingInvocationsSenders
				select: [ :sender | sender parentType = aSource ].
			senders ifNotEmpty: [ result at: aMethod put: senders asSet ] ].
	^ result
]
