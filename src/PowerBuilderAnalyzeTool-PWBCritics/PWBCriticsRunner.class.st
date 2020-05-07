Class {
	#name : #PWBCriticsRunner,
	#superclass : #Object,
	#instVars : [
		'criticResults'
	],
	#category : #'PowerBuilderAnalyzeTool-PWBCritics'
}

{ #category : #initialization }
PWBCriticsRunner >> initialize [
	super initialize.
	criticResults := Dictionary new
]
