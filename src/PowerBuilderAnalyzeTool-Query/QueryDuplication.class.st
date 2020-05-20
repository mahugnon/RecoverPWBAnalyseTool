Class {
	#name : #QueryDuplication,
	#superclass : #AbstractPWBQuery,
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
		detect: [ :alo | alo accept: aPWBDuplicationParameter backEndClass ]) new
		runOn: aPWBDuplicationParameter
]

{ #category : #running }
QueryDuplication >> createBackEndFrom: aPWBDuplicationParameter [
	self subclassResponsibility
]

{ #category : #running }
QueryDuplication >> executeBackEndOn: aPWBDuplicationParameter [
	^ self class backEndClass
		configuration: (self createBackEndFrom: aPWBDuplicationParameter);
		runOn: aPWBDuplicationParameter entities
]

{ #category : #running }
QueryDuplication >> fragmentFrom: aPWBDuplicationParameter [
	^ self subclassResponsibility
]

{ #category : #running }
QueryDuplication >> runOn: aPWBDuplicationParameter [
	^ (PowerbuliderDuplicationSystem
		withAll: (self fragmentFrom: aPWBDuplicationParameter))
		setColors;
		fragments
]
