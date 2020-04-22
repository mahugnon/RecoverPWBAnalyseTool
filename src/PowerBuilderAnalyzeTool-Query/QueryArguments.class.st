Class {
	#name : #QueryArguments,
	#superclass : #AbstractPWBQuery,
	#category : #'PowerBuilderAnalyzeTool-Query'
}

{ #category : #running }
QueryArguments >> runOn: aCollection [
	^ (aCollection reject: [ :each | each class = FamixPWBAttribute ])
		select: #isArgument
]
