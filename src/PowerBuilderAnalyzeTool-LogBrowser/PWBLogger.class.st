Class {
	#name : #PWBLogger,
	#superclass : #Object,
	#instVars : [
		'logs',
		'application'
	],
	#category : #'PowerBuilderAnalyzeTool-LogBrowser'
}

{ #category : #accessing }
PWBLogger >> application [
	^ application
]

{ #category : #accessing }
PWBLogger >> application: aPWBApplication [
	application := aPWBApplication
]

{ #category : #enumerating }
PWBLogger >> globallySelect: anEntity [
	logs
		add:
			(PWBSelectedEntityLog new
				logger: self;
				entity: anEntity)
]

{ #category : #initialization }
PWBLogger >> initialize [
	super initialize.
	logs := OrderedCollection new
]

{ #category : #accessing }
PWBLogger >> logs [
	^ logs
]

{ #category : #accessing }
PWBLogger >> logs: anObject [
	logs := anObject
]
