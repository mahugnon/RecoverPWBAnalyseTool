Class {
	#name : #QueryArguments,
	#superclass : #AbstractPWBQuery,
	#category : #'PowerBuilderAnalyzeTool-Query'
}

{ #category : #running }
QueryArguments >> runOn: anFamixPWBBehavior [
	^ (anFamixPWBBehavior variables
		reject: [ :each | each class = FamixPWBAttribute ])
		select: #isArgument
]
