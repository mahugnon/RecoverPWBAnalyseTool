Class {
	#name : #PWBMooseModelBrowser,
	#superclass : #PWBAbstractBrowser,
	#instVars : [
		'modelPresenter',
		'searchField',
		'allModelPWBObjectButton',
		'scopedView'
	],
	#category : #'PowerBuilderAnalyzeTool-Browsers'
}

{ #category : #specs }
PWBMooseModelBrowser class >> defaultSpec [
	^ super defaultSpec
		add: #modelPresenter;
		add:
			(SpBoxLayout newHorizontal
				add: #allModelPWBObjectButton;
				add: #scopedView;
				yourself)
			withConstraints: [ :contraint | contraint height: 20 ];
		yourself
]

{ #category : #examples }
PWBMooseModelBrowser class >> runMe [
	<script>
	self new openWithSpec
]

{ #category : #visiting }
PWBMooseModelBrowser >> accept: anObject [
	^ ({DPFragmentLocation.
	FamixPWBEvent} includes: anObject class) not
]

{ #category : #initialization }
PWBMooseModelBrowser >> connectPresenters [
	super connectPresenters.
	self radioButtonsAction
]

{ #category : #accessing }
PWBMooseModelBrowser >> follow [
	^ follow
]

{ #category : #accessing }
PWBMooseModelBrowser >> followAction [
	(self needUpdate: toSelect)
		ifFalse: [ ^ self ].
	modelPresenter roots: {toSelect}
	"self needRebuild: false.
	self buildWithSpec"
]

{ #category : #accessing }
PWBMooseModelBrowser >> highlightAction [
	(self needUpdate: toSelect)
		ifFalse: [ ^ self ].
	modelPresenter selectItem: toSelect
	"self needRebuild: false.
	self buildWithSpec"
]

{ #category : #initialization }
PWBMooseModelBrowser >> initialize [
	super initialize.
	freeze state: true
]

{ #category : #initialization }
PWBMooseModelBrowser >> initializePresenters [
	super initializePresenters.
	model := PWBMooseModelBrowserModel new.
	self initializeTable.
	self initializeSearchField.
	modelPresenter
		whenSelectionChangedDo: [ :selected | 
			self halt.
			model selected: selected selectedItem.
			self freezeDuring: [ self globallySelect: selected selectedItem ] ].
	searchField whenTextIsAcceptedDo: [ :text | self searchFor: text ].
	self viewRadioButton
]

{ #category : #initialization }
PWBMooseModelBrowser >> initializeSearchField [
	searchField := self newTextInput
		placeholder: 'Search entities ...';
		yourself.
	searchField acceptOnCR: true
]

{ #category : #initialization }
PWBMooseModelBrowser >> initializeTable [
	modelPresenter := self newList.
	modelPresenter
		display: [ :item | item name ];
		icons: [ :each | each systemIcon ];
		sortingBlock: [ :a :b | a methods asSet size > b methods asSet size ];
		enableItemSubstringFilter;
		items: model pwbMooseModel asOrderedCollection
]

{ #category : #accessing }
PWBMooseModelBrowser >> modelPresenter [
	^ modelPresenter
]

{ #category : #'initialization - actions' }
PWBMooseModelBrowser >> radioButtonsAction [
	allModelPWBObjectButton
		whenActivatedDo: [ modelPresenter items: model pwbMooseModel ].
	scopedView
		whenActivatedDo: [ modelPresenter items: {modelPresenter selection selectedItem} ]
]

{ #category : #initialization }
PWBMooseModelBrowser >> searchFor: aText [
	modelPresenter adapter widget function searchFor: aText
]

{ #category : #accessing }
PWBMooseModelBrowser >> selected [
	^ model selected
]

{ #category : #testing }
PWBMooseModelBrowser >> setModelPresenterSelection [
	modelPresenter selectItem: modelPresenter model items first
]

{ #category : #TOREMOVE }
PWBMooseModelBrowser >> title [
^'MooseModel Browser'
]

{ #category : #initialization }
PWBMooseModelBrowser >> viewRadioButton [
	allModelPWBObjectButton := self newRadioButton.
	allModelPWBObjectButton label: 'All PWBObjects'.
	scopedView := self newRadioButton.
	scopedView label: 'Scoped View'.
	allModelPWBObjectButton associatedRadioButtons: {scopedView}
]
