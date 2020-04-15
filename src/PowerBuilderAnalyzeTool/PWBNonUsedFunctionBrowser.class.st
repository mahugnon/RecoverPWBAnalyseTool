Class {
	#name : #PWBNonUsedFunctionBrowser,
	#superclass : #PWBAbstractBrowser,
	#instVars : [
		'diagram',
		'view'
	],
	#category : #'PowerBuilderAnalyzeTool-Browsers'
}

{ #category : #specs }
PWBNonUsedFunctionBrowser class >> defaultSpec [
	^ super defaultSpec
		add: #diagram;
		yourself
]

{ #category : #'as yet unclassified' }
PWBNonUsedFunctionBrowser class >> lunchOn: anObject [
	^ self new
		selected: anObject;
		openWithSpec
]

{ #category : #visiting }
PWBNonUsedFunctionBrowser >> accept: anObject [
	^ anObject class = FamixPWBUserObject
]

{ #category : #accessing }
PWBNonUsedFunctionBrowser >> diagram [
	^ diagram
]

{ #category : #accessing }
PWBNonUsedFunctionBrowser >> diagram: anObject [
	diagram := anObject
]

{ #category : #drawing }
PWBNonUsedFunctionBrowser >> drawOn: aView [
	| es |
	aView @ RTDraggableView @ RTZoomableView.
	es := (RTBox new
		size: 15;
		color: Color gray) elementsOn: model pwbMooseModel.
	aView addAll: es.
	es @ RTDraggable.
	es
		@
			(RTLabeled new
				fontSize: 5;
				top;
				text: [ :method | 
					(method parentType
						ifNotNil: [ method parentType name , '.' ]
						ifNil: [ '' ]) , method name ]).
	RTMetricNormalizer new
		elements: es;
		normalizeSize: #numberOfLinesOfCode.
	RTCircleLayout new on: aView elements.
	^ aView build
]

{ #category : #initialization }
PWBNonUsedFunctionBrowser >> initializeDiagram [
	diagram := self instantiate: RoassalModel.
	diagram
		script: [ :aView :canvas | 
			self drawOn: aView.
			view := aView.
			aView canvas focusOnCenterScaled ]
]

{ #category : #initialization }
PWBNonUsedFunctionBrowser >> initializePresenters [
	super initializePresenters.
	model := PWBNonUsedFunctionBrowserModel new.
	self initializeDiagram
]

{ #category : #refreshing }
PWBNonUsedFunctionBrowser >> refresh [
	model pwbMooseModel isEmpty
		ifTrue: [ diagram := self newNullPresenter ]
		ifFalse: [ self initializeDiagram ].
	self needRebuild: false.
	self buildWithSpec
]

{ #category : #accessing }
PWBNonUsedFunctionBrowser >> selectEntity: anEntity [
	((self accept: anEntity)
		and: ((self needUpdate: anEntity) and: self isNotFreeze))
		ifFalse: [ ^ self ].
	model selected: anEntity.
	self refresh
]

{ #category : #accessing }
PWBNonUsedFunctionBrowser >> selected [
	^ model selected
]

{ #category : #accessing }
PWBNonUsedFunctionBrowser >> selected: aFamixPWBUserObject [
	model selected: aFamixPWBUserObject
]

{ #category : #initialization }
PWBNonUsedFunctionBrowser >> title [
	^ 'Dead methods Browser'
]

{ #category : #accessing }
PWBNonUsedFunctionBrowser >> view [
	^ view
]

{ #category : #accessing }
PWBNonUsedFunctionBrowser >> view: anObject [
	view := anObject
]

{ #category : #initialization }
PWBNonUsedFunctionBrowser >> zoomIn [
	RTZoomInMove on: view
]

{ #category : #initialization }
PWBNonUsedFunctionBrowser >> zoomOut [
	RTZoomOutMove on: view
]
