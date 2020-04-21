Class {
	#name : #PWBDeadMethodsBrowser,
	#superclass : #PWBAbstractBrowser,
	#instVars : [
		'deadMethodPresenter'
	],
	#category : #'PowerBuilderAnalyzeTool-Browsers'
}

{ #category : #specs }
PWBDeadMethodsBrowser class >> defaultSpec [
	^ super defaultSpec
		add: #deadMethodPresenter;
		yourself
]

{ #category : #running }
PWBDeadMethodsBrowser class >> run [
	<script>
	self new openWithSpec
]

{ #category : #visiting }
PWBDeadMethodsBrowser >> accept: anObject [
	^ FamixPWBmajorObject subclasses includes: anObject class
]

{ #category : #actions }
PWBDeadMethodsBrowser >> followAction [
	(self needUpdate: toSelect)
		ifFalse: [ ^ self ].
	model selected: toSelect.
	deadMethodPresenter
		headerTitle: model selected name;
		items: model pwbMooseModel
]

{ #category : #actions }
PWBDeadMethodsBrowser >> highlightAction [
	self followAction
]

{ #category : #initialization }
PWBDeadMethodsBrowser >> initializePresenters [
	super initializePresenters.
	model := PWBDeadMethodsBrowserModel new.
	model pwbBrowser: self.
	deadMethodPresenter := self newList.
	deadMethodPresenter
		display: [ :item | item name ];
		icons: [ :each | each systemIcon ];
		sortingBlock: [ :a :b | a name < b name ];
		enableItemSubstringFilter;
		items: #()
]

{ #category : #initialization }
PWBDeadMethodsBrowser >> initializeWindow: aWindowPresenter [ 
super initializeWindow: aWindowPresenter .
aWindowPresenter 	initialExtent: 350 @ 300
]

{ #category : #accessing }
PWBDeadMethodsBrowser >> selected [
	^ self model selected
]

{ #category : #TOREMOVE }
PWBDeadMethodsBrowser >> title [
^'Dead Methods Browser'
]
