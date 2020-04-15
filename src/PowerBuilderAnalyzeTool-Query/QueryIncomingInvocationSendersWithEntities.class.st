Class {
	#name : #QueryIncomingInvocationSendersWithEntities,
	#superclass : #QueryIncomingInvocationSenders,
	#category : #'PowerBuilderAnalyzeTool-Query'
}

{ #category : #visiting }
QueryIncomingInvocationSendersWithEntities class >> accept: anObject [
	^ anObject = InvocationWithEntitiesOption
]

{ #category : #running }
QueryIncomingInvocationSendersWithEntities >> runOn: anEntity [
	| result |
	result := anEntity incomingInvocationsSenders.
	result
		addAll: (options selectedEntities flatCollect: #incomingInvocationsSenders).
	^ result asOrderedCollection
]
