Class {
	#name : #PowerbuliderDuplicationParam,
	#superclass : #Object,
	#instVars : [
		'minimumNumberOfLines',
		'minimumNumberOfDuplication',
		'minimumNumberOfCharacters',
		'sourcesCleaner',
		'entities',
		'backEndClass'
	],
	#category : #'PowerBuilderAnalyzeTool-DuplicationGUI'
}

{ #category : #accessing }
PowerbuliderDuplicationParam class >> default [
	^ self new
		minNumberOfLines: 20;
		minNumberOfCharacters: 160;
		backEndClass: FamixRepDetector
]

{ #category : #accessing }
PowerbuliderDuplicationParam >> backEndClass [
	^ backEndClass
]

{ #category : #accessing }
PowerbuliderDuplicationParam >> backEndClass: anObject [
	backEndClass := anObject
]

{ #category : #accessing }
PowerbuliderDuplicationParam >> entities [
	^ entities
]

{ #category : #accessing }
PowerbuliderDuplicationParam >> entities: anObject [
	entities := anObject
]

{ #category : #accessing }
PowerbuliderDuplicationParam >> minimumNumberOfCharacters [
	^ minimumNumberOfCharacters
]

{ #category : #accessing }
PowerbuliderDuplicationParam >> minimumNumberOfCharacters: anObject [
	minimumNumberOfCharacters := anObject
]

{ #category : #accessing }
PowerbuliderDuplicationParam >> minimumNumberOfDuplication [
	^ minimumNumberOfDuplication
]

{ #category : #accessing }
PowerbuliderDuplicationParam >> minimumNumberOfDuplication: anObject [
	minimumNumberOfDuplication := anObject
]

{ #category : #accessing }
PowerbuliderDuplicationParam >> minimumNumberOfLines [
	^ minimumNumberOfLines
]

{ #category : #accessing }
PowerbuliderDuplicationParam >> minimumNumberOfLines: anObject [
	minimumNumberOfLines := anObject
]

{ #category : #accessing }
PowerbuliderDuplicationParam >> sourcesCleaner [
	^ sourcesCleaner
]

{ #category : #accessing }
PowerbuliderDuplicationParam >> sourcesCleaner: anObject [
	sourcesCleaner := anObject
]
