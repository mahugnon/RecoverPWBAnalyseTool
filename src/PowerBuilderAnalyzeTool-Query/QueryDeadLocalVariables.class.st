Class {
	#name : #QueryDeadLocalVariables,
	#superclass : #AbstractPWBQuery,
	#category : #'PowerBuilderAnalyzeTool-Query'
}

{ #category : #running }
QueryDeadLocalVariables >> runOn: aCollection [
	^ aCollection select: #isLocal
]
