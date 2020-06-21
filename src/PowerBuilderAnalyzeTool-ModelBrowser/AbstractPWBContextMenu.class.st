Class {
	#name : #AbstractPWBContextMenu,
	#superclass : #Object,
	#instVars : [
		'entities',
		'presenterModel'
	],
	#category : #'PowerBuilderAnalyzeTool-ModelBrowser-Browser'
}

{ #category : #visiting }
AbstractPWBContextMenu class >> accept: anEntity [
	^ self subclassResponsibility
]

{ #category : #'as yet unclassified' }
AbstractPWBContextMenu class >> pwbContextMenu: anEntity [
	^ (self subclasses detect: [ :menu | menu accept: anEntity ]) new
]

{ #category : #actions }
AbstractPWBContextMenu >> actions [
	^ {}
]

{ #category : #accessing }
AbstractPWBContextMenu >> entities [
	^ entities
]

{ #category : #accessing }
AbstractPWBContextMenu >> entities: anObject [
	entities := anObject
]

{ #category : #accessing }
AbstractPWBContextMenu >> presenterModel [
	^ presenterModel
]

{ #category : #accessing }
AbstractPWBContextMenu >> presenterModel: anObject [
	presenterModel := anObject
]
