Class {
	#name : #QueryBehavioral,
	#superclass : #AbstractPWBQuery,
	#category : #'PowerBuilderAnalyzeTool-Query'
}

{ #category : #visiting }
QueryBehavioral class >> accept: aString [
	^ self subclassResponsibility
]

{ #category : #'as yet unclassified' }
QueryBehavioral class >> runOn: aCollection for: aString [
	^ self subclasses
		detect: [ :each | each accept: aString ]
		ifFound: [ :founded | founded runOn: aCollection ]
		ifNone: [ {} ]
]

{ #category : #running }
QueryBehavioral >> runOn: anFamixPWBBehavior [
	^ ((anFamixPWBBehavior variables
		reject: [ :each | each class = FamixPWBAttribute ])
		collectAsSet: [ :var | var behavioralForIfDead ])
		asOrderedCollection
]
