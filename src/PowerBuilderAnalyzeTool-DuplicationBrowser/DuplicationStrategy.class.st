Class {
	#name : #DuplicationStrategy,
	#superclass : #Object,
	#instVars : [
		'pWBDuplicationParameter'
	],
	#category : #'PowerBuilderAnalyzeTool-DuplicationBrowser-BackEndStrategy'
}

{ #category : #visiting }
DuplicationStrategy class >> accept: aBackEndClass [
	^ aBackEndClass = self backEndClass
]

{ #category : #visiting }
DuplicationStrategy class >> backEndClass [
	^ self subclassResponsibility
]

{ #category : #running }
DuplicationStrategy class >> chooseBackEndFor: aPWBDuplicationParameter [
	^ self subclasses
		detect: [ :algo | algo accept: aPWBDuplicationParameter backEndClass ]
]

{ #category : #'as yet unclassified' }
DuplicationStrategy class >> pwbName [
	^ self backEndClass name
]

{ #category : #running }
DuplicationStrategy class >> runOn: aPWBDuplicationParameter [
	^ (self chooseBackEndFor: aPWBDuplicationParameter) new
		pWBDuplicationParameter: aPWBDuplicationParameter;
		run
]

{ #category : #running }
DuplicationStrategy >> backEnd [
	^ self class backEndClass new
]

{ #category : #running }
DuplicationStrategy >> createBackEndParameter [
	^ self subclassResponsibility
]

{ #category : #running }
DuplicationStrategy >> fragmentsFromBackEnd [
	^ self subclassResponsibility
]

{ #category : #accessing }
DuplicationStrategy >> pWBDuplicationParameter: aPWBDuplicationParameter [
	pWBDuplicationParameter := aPWBDuplicationParameter
]

{ #category : #running }
DuplicationStrategy >> run [
	^ (PowerbuliderDuplicationSystem withAll: self fragmentsFromBackEnd)
		setColors;
		fragments
]
