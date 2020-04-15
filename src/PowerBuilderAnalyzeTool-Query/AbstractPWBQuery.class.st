Class {
	#name : #AbstractPWBQuery,
	#superclass : #Object,
	#category : #'PowerBuilderAnalyzeTool-Query'
}

{ #category : #running }
AbstractPWBQuery class >> runOn: anObject [
	^ self new runOn: anObject
]

{ #category : #running }
AbstractPWBQuery >> runOn: aCollection [
	^ self subclassResponsibility
]
