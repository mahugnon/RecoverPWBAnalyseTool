Class {
	#name : #PWBDeadMethodsBrowserModel,
	#superclass : #PWBAbstractModel,
	#instVars : [
		'query'
	],
	#category : #'PowerBuilderAnalyzeTool-DeadMethodBrowser-Model'
}

{ #category : #accessing }
PWBDeadMethodsBrowserModel >> initialize [
	super initialize.
	query := QueryDeadMethods new
]

{ #category : #accessing }
PWBDeadMethodsBrowserModel >> selected: anObject [
	selected := anObject.
	pwbMooseModel := selected flatCollect: [ :uo | query runOn: uo ]
]
