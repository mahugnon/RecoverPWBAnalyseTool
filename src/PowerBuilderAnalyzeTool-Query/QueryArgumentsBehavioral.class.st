Class {
	#name : #QueryArgumentsBehavioral,
	#superclass : #QueryBehavioral,
	#category : #'PowerBuilderAnalyzeTool-Query'
}

{ #category : #visiting }
QueryArgumentsBehavioral class >> accept: aString [
	^ 'Arguments' = aString
]

{ #category : #running }
QueryArgumentsBehavioral >> runOn: aCollection [
	^ (super runOn: (aCollection select: #isArgument))
		asOrderedCollection
]
