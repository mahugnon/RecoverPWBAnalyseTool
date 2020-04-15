Class {
	#name : #QueryDeadVariables,
	#superclass : #AbstractPWBQuery,
	#instVars : [
		'result'
	],
	#category : #'PowerBuilderAnalyzeTool-Query'
}

{ #category : #accessing }
QueryDeadVariables >> instanceVariables [
	^ (result select: [ :each | each name matchesRegex: 'i.*' ])
		asOrderedCollection
]

{ #category : #running }
QueryDeadVariables >> runOn: anObject [
	| variables |
	variables := anObject methods asSet flatCollectAsSet: #variables.
	variables addAll: anObject attributes.
	result := variables select: [ :each | each incomingAccesses isEmpty ]
]

{ #category : #accessing }
QueryDeadVariables >> variables [
	^ (result reject: [ :each | each name matchesRegex: 'i.*' ])
		asCollection
]
