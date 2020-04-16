Class {
	#name : #PWBAbstractBrowser,
	#superclass : #PWBPresenter,
	#instVars : [
		'model',
		'freeze',
		'follow',
		'highlight',
		'toSelect'
	],
	#category : #'PowerBuilderAnalyzeTool-Browsers'
}

{ #category : #specs }
PWBAbstractBrowser class >> defaultSpec [
	^ SpBoxLayout newVertical
		add:
			(SpBoxLayout newHorizontal
				add: #follow expand: false;
				add: #highlight expand: false;
				add: #freeze expand: false;
				yourself)
			withConstraints: [ :constraints | constraints height: self toolbarHeight ];
		yourself
]

{ #category : #visiting }
PWBAbstractBrowser >> accept: anObject [
	^ self subclassResponsibility
]

{ #category : #'as yet unclassified' }
PWBAbstractBrowser >> followAction [
	^ self subclassResponsibility
]

{ #category : #api }
PWBAbstractBrowser >> freezeAction [
	^ self
]

{ #category : #'as yet unclassified' }
PWBAbstractBrowser >> freezeDuring: aBlock [
	| tmpState |
	tmpState := {follow.
	highlight.
	freeze} detect: [ :each | each state ].
	self toFreeze.
	aBlock
		ensure: [ tmpState state: true ]
]

{ #category : #enumerating }
PWBAbstractBrowser >> globallySelect: anEntity [
	self application globallySelect: anEntity
]

{ #category : #'as yet unclassified' }
PWBAbstractBrowser >> highlightAction [
	^ self subclassResponsibility
]

{ #category : #initialization }
PWBAbstractBrowser >> initializePresenters [
	freeze := self newRadioButton.
	follow := self newRadioButton.
	highlight := self newRadioButton.
	follow
		associatedRadioButtons:
			{freeze.
			highlight}.
	freeze label: 'Ignore'.
	follow label: 'Follow'.
	highlight label: 'Highlight'.
	follow state: false
]

{ #category : #initialization }
PWBAbstractBrowser >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		whenClosedDo: [ self application windowClosed: aWindowPresenter ].
	aWindowPresenter
		title: self title;
		initialExtent: 600 @ 500
]

{ #category : #initialization }
PWBAbstractBrowser >> isFollow [
	^ follow state
]

{ #category : #accessing }
PWBAbstractBrowser >> isFreeze [
	^ freeze state
]

{ #category : #initialization }
PWBAbstractBrowser >> isHighlight [
	^ highlight state
]

{ #category : #testing }
PWBAbstractBrowser >> isNotFreeze [
	^ self isFreeze not
]

{ #category : #testing }
PWBAbstractBrowser >> isPWBBrowser [
	^ true
]

{ #category : #accessing }
PWBAbstractBrowser >> model [
	^ model
]

{ #category : #accessing }
PWBAbstractBrowser >> model: anObject [
	model := anObject
]

{ #category : #api }
PWBAbstractBrowser >> needUpdate: anEntity [
	^ anEntity ~= model selected and: [ self accept: anEntity ]
]

{ #category : #accessing }
PWBAbstractBrowser >> selectEntity: anEntity [
	toSelect := anEntity.
	AbstractBrowserMode actionFor: self
]

{ #category : #initialization }
PWBAbstractBrowser >> toFollow [
	follow state: true
]

{ #category : #accessing }
PWBAbstractBrowser >> toFreeze [
	freeze state: true
]

{ #category : #initialization }
PWBAbstractBrowser >> toHighlight [
	^ highlight state: true
]
