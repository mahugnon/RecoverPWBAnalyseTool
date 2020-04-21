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
			| invs |
			invs := aMethod incomingInvocations
				select: [ :inv | inv sender parentType = aSource ].
			invs ifNotEmpty: [ result at: aMethod put: invs asSet ] ].
	^ result
]
