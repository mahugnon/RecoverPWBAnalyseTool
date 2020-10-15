Class {
	#name : #QueryPresentationGroupAttributes,
	#superclass : #AbstractPWBQuery,
	#category : #'PowerBuilderAnalyzeTool-Query'
}

{ #category : #running }
QueryPresentationGroupAttributes >> runOn: aCollection [
	^ (aCollection flatCollect: #attributes as: Set)
		reject: [ :att | att incomingAccesses isEmpty ]
]
