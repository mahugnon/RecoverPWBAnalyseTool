Class {
	#name : #QueryDuplication,
	#superclass : #AbstractPWBQuery,
	#instVars : [
		'pWBDuplicationParameter'
	],
	#category : #'PowerBuilderAnalyzeTool-Query'
}

{ #category : #visiting }
QueryDuplication class >> accept: aBackEndClass [
	^ aBackEndClass = self backEndClass
]

{ #category : #visiting }
QueryDuplication class >> backEndClass [
	^ self subclassResponsibility
]

{ #category : #running }
QueryDuplication class >> runOn: aPWBDuplicationParameter [
	^ (self subclasses
		detect: [ :alo | alo accept: aPWBDuplicationParameter backEndClass ])
		new
		pWBDuplicationParameter: aPWBDuplicationParameter;
		run
]

{ #category : #running }
QueryDuplication >> backEnd [
	^ self class backEndClass new
]

{ #category : #running }
QueryDuplication >> createBackEndParameter [
	^ self subclassResponsibility
]

{ #category : #running }
QueryDuplication >> fragmentsFromBackEnd [
	^ self subclassResponsibility
]

{ #category : #accessing }
QueryDuplication >> pWBDuplicationParameter: aPWBDuplicationParameter [
	pWBDuplicationParameter := aPWBDuplicationParameter
]

{ #category : #running }
QueryDuplication >> run [
	^ (PowerbuliderDuplicationSystem withAll: self fragmentsFromBackEnd)
		setColors;
		fragments
]

{ #category : #running }
QueryDuplication >> runOn: aCollection [
	
]
