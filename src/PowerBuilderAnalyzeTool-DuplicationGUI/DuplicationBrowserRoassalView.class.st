Class {
	#name : #DuplicationBrowserRoassalView,
	#superclass : #SpPresenter,
	#instVars : [
		'model',
		'duplicationDiagram',
		'canvas'
	],
	#category : #'PowerBuilderAnalyzeTool-DuplicationGUI-roassal'
}

{ #category : #specs }
DuplicationBrowserRoassalView class >> defaultSpec [
  ^SpBoxLayout newVertical
     add: #duplicationDiagram;
     yourself
]

{ #category : #'as yet unclassified' }
DuplicationBrowserRoassalView class >> viewName [
	^ self subclassResponsibility
]

{ #category : #'as yet unclassified' }
DuplicationBrowserRoassalView class >> views [
	^ self subclasses
]

{ #category : #'as yet unclassified' }
DuplicationBrowserRoassalView >> drawDuplicationDiagramOn: anObject [

]

{ #category : #initialization }
DuplicationBrowserRoassalView >> drawOn: aView [
	^ self subclassResponsibility
]

{ #category : #initialization }
DuplicationBrowserRoassalView >> initializeDuplicationDiagram [
	duplicationDiagram := self instantiate: SpRoassalPresenter.
	duplicationDiagram script: [ :aCanvas | self drawOn: aCanvas ]
]

{ #category : #initialization }
DuplicationBrowserRoassalView >> initializeWidgets [
  model := DuplicationBrowserModel new.
  self initializeDuplicationDiagram
]

{ #category : #accessing }
DuplicationBrowserRoassalView >> model: anObject [
  model := anObject.
  model duplicationView: self
]

{ #category : #updating }
DuplicationBrowserRoassalView >> updateView [
  self update
]
