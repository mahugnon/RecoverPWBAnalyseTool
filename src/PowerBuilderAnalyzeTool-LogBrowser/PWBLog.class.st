Class {
	#name : #PWBLog,
	#superclass : #Object,
	#instVars : [
		'logger',
		'time'
	],
	#category : #'PowerBuilderAnalyzeTool-LogBrowser'
}

{ #category : #activation }
PWBLog >> activate [
	self subclassResponsibility
]

{ #category : #accessing }
PWBLog >> application [
	^ self logger application
]

{ #category : #accessing }
PWBLog >> logger [
	^ logger
]

{ #category : #accessing }
PWBLog >> logger: aPWBLogger [
	logger := aPWBLogger
]

{ #category : #accessing }
PWBLog >> time [
	^ time
]

{ #category : #accessing }
PWBLog >> time: anObject [
	time := anObject
]
