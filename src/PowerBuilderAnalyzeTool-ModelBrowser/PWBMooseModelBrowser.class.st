Class {
	#name : #PWBMooseModelBrowser,
	#superclass : #PWBAbstractBrowser,
	#instVars : [
		'modelPresenter',
		'searchField',
		'allModelPWBObjectButton',
		'scopedView',
		'separator'
	],
	#category : #'PowerBuilderAnalyzeTool-ModelBrowser-Browser'
}

{ #category : #specs }
PWBMooseModelBrowser class >> defaultSpec [
	^ SpBoxLayout newVertical
		add: #propagateButton
			withConstraints: [ :constraints | 
			constraints
				height: self toolbarHeight;
				width: 100;
				expand: false ];
		add:
			(SpBoxLayout newHorizontal
				add: #follow
					withConstraints: [ :constraints | 
					constraints
						height: self toolbarHeight;
						width: 100;
						expand: false ];
				add: #highlight
					withConstraints: [ :constraints | 
					constraints
						height: self toolbarHeight;
						width: 100;
						expand: false ];
				add: #freeze
					withConstraints: [ :constraints | 
					constraints
						height: self toolbarHeight;
						width: 100;
						expand: false ];
				add: #separator
					withConstraints: [ :constraints | 
					constraints
						height: self toolbarHeight;
						width: 50;
						expand: false ];
				add:
					(SpBoxLayout newHorizontal
						add: #allModelPWBObjectButton;
						add: #scopedView;
						yourself)
					withConstraints: [ :contraint | contraint height: 20 ];
				yourself)
			withConstraints: [ :constraints | constraints height: self toolbarHeight ];
		add: #modelPresenter;
		yourself
]

{ #category : #examples }
PWBMooseModelBrowser class >> runMe [
	<script>
	self new
		setUp;
		openWithSpec
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
			model selected: (FamixTypeGroup withAll: modelPresenter selectedItems).
			AbstractBrowserSenderMode actionFor: self ].
	searchField whenTextIsAcceptedDo: [ :text | self searchFor: text ].
	self viewRadioButton.
	separator := self newLabel
		label: '|';
		emphasis: #bold;
		color: Color white;
		yourself
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
		beMultipleSelection;
		display: [ :item | item name ];
		icons: [ :each | each systemIcon ];
		sortingBlock: [ :a :b | a methods asSet size > b methods asSet size ];
		enableItemSubstringFilter
]

{ #category : #'accessing ' }
PWBMooseModelBrowser >> isPropagate [
	^ propagateButton state
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
		whenActivatedDo: [ modelPresenter items: modelPresenter selectedItems.
			modelPresenter selectItems: modelPresenter model items.
			self needRebuild: false.
			self buildWithSpec ]
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

{ #category : #initialization }
PWBMooseModelBrowser >> setUp [
	model setUp.
	modelPresenter items: model pwbMooseModel asOrderedCollection.
	self needRebuild: false.
	self buildWithSpec
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
