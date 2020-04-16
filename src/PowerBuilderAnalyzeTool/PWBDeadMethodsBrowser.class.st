Class {
	#name : #PWBDeadMethodsBrowser,
	#superclass : #PWBAbstractBrowser,
	#instVars : [
		'deadMethodPresenter'
	],
	#category : #'PowerBuilderAnalyzeTool-Browsers'
}

{ #category : #running }
PWBDeadMethodsBrowser class >> run [
	self new openWithSpec
]

{ #category : #visiting }
PWBDeadMethodsBrowser >> accept: anObject [
	^ anObject class = FamixPWBmajorObject
]

{ #category : #'as yet unclassified' }
PWBDeadMethodsBrowser >> followAction [
	(self needUpdate: toSelect)
		ifFalse: [ self ].
	model selected: toSelect.
	deadMethodPresenter items: model pwbMooseModel
]

{ #category : #'as yet unclassified' }
PWBDeadMethodsBrowser >> highlightAction [
	self followAction
]

{ #category : #initialization }
PWBDeadMethodsBrowser >> initializePresenters [
	deadMethodPresenter := self newList.
	deadMethodPresenter
		display: [ :item | item name ];
		icons: [ :each | each systemIcon ];
		sortingBlock: [ :a :b | a name < b name ];
		enableItemSubstringFilter;
		items: #()
]
