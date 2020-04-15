Class {
	#name : #CIMRoassalPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'diagram',
		'guiModel',
		'view',
		'currentFocus'
	],
	#category : #'PowerBuilderAnalyzeTool-CallTree-TreeBase-Presenters'
}

{ #category : #specs }
CIMRoassalPresenter class >> defaultSpec [
	^ SpBoxLayout  newHorizontal
		add: #diagram;
		yourself
]

{ #category : #'as yet unclassified' }
CIMRoassalPresenter >> adapterFrom: aCollection [
  ^self pwbMooseModel select: [:each |  aCollection includes: each pwbMooseModel ]
]

{ #category : #accessing }
CIMRoassalPresenter >> application [
	^ owner application
]

{ #category : #hooks }
CIMRoassalPresenter >> colorSelectedElement: element [
	currentFocus
		ifNotNil: [ currentFocus color: (ColorObject colorFor: currentFocus model) ].
	currentFocus := element.
	^ currentFocus color: Color paleGreen
]

{ #category : #accessing }
CIMRoassalPresenter >> diagram [
	^ diagram
]

{ #category : #accessing }
CIMRoassalPresenter >> diagram: anObject [
	diagram := anObject
]

{ #category : #initialization }
CIMRoassalPresenter >> drawOn: aView [
	^ self subclassResponsibility
]

{ #category : #accessing }
CIMRoassalPresenter >> guiModel [
	^ guiModel
]

{ #category : #accessing }
CIMRoassalPresenter >> guiModel: anObject [
	guiModel := anObject
]

{ #category : #util }
CIMRoassalPresenter >> highlight: anEntity [
	self subclassResponsibility
]

{ #category : #initialization }
CIMRoassalPresenter >> initializeDiagram [
	diagram := self instantiate: SpRoassalPresenter.
	diagram
		script: [ :canvas | 
			self drawOn: canvas.
			view := canvas ]
]

{ #category : #initialization }
CIMRoassalPresenter >> initializeWidgets [
  self initializeDiagram
]

{ #category : #initialization }
CIMRoassalPresenter >> legend: aCanvas [
	self subclassResponsibility
]

{ #category : #initialization }
CIMRoassalPresenter >> processEntityClickEvent: evt [
	| element |
	element := evt shape.
	guiModel selected: element model.
	self colorSelectedElement: element.
	guiModel
		freezeDuring: [ self application globallySelect: element model ]
]

{ #category : #accessing }
CIMRoassalPresenter >> pwbMooseModel [
	| senders |
	senders := guiModel selectedMethodsInvocationsSendersParents asSet.
	senders add: guiModel selected.
	^ senders
]

{ #category : #accessing }
CIMRoassalPresenter >> view [
	^ view
]

{ #category : #initialization }
CIMRoassalPresenter >> zoomIn [
	RTZoomInMove on: view
]

{ #category : #initialization }
CIMRoassalPresenter >> zoomOut [
	RTZoomOutMove on: view
]
