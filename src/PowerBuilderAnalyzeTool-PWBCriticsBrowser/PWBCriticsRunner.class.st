Class {
	#name : #PWBCriticsRunner,
	#superclass : #Object,
	#instVars : [
		'criticResults',
		'files'
	],
	#category : #'PowerBuilderAnalyzeTool-PWBCriticsBrowser'
}

{ #category : #running }
PWBCriticsRunner class >> runOn: aCollection [
	^ self new
		files: aCollection;
		runAll
]

{ #category : #accessing }
PWBCriticsRunner >> files: aCollection [
	files := aCollection
	
]

{ #category : #initialization }
PWBCriticsRunner >> initialize [
	super initialize.
	criticResults := Dictionary new
]

{ #category : #actions }
PWBCriticsRunner >> runAll [
	files
		do:
			[ :aFile | criticResults at: aFile name put: (PWBCriticsResult new file: aFile) ]
]
