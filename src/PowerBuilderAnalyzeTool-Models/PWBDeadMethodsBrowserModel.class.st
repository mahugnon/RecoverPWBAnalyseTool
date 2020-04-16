Class {
	#name : #PWBDeadMethodsBrowserModel,
	#superclass : #PWBAbstractModel,
	#instVars : [
		'query'
	],
	#category : #'PowerBuilderAnalyzeTool-Models'
}

{ #category : #accessing }
PWBDeadMethodsBrowserModel >> initialize [
	super initialize.
	query := QueryDeadMethods new
]

{ #category : #accessing }
PWBDeadMethodsBrowserModel >> selected: anObject [
	selected := anObject.
	pwbMooseModel := query runOn: selected
]
