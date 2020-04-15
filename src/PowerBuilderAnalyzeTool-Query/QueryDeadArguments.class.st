Class {
	#name : #QueryDeadArguments,
	#superclass : #AbstractPWBQuery,
	#category : #'PowerBuilderAnalyzeTool-Query'
}

{ #category : #running }
QueryDeadArguments >> runOn: aCollection [
	^ aCollection select: #isArgument
]
