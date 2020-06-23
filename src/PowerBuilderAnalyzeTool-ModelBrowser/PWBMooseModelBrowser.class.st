Class {
	#name : #PWBMooseModelBrowser,
	#superclass : #PWBAbstractBrowser,
	#instVars : [
		'modelPresenter',
		'searchField',
		'allModelPWBObjectButton',
		'scopedView',
		'separator',
		'menu',
		'millerModelPresenter'
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
		add: #millerModelPresenter;
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
	modelPresenter items: {toSelect}
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
PWBMooseModelBrowser >> initializeMilerModelPresenter [
	millerModelPresenter := self instantiate: PWBSpMillerColumnPresenter.
	millerModelPresenter
		presenterBlock: [ :aModel | self initializePresenterFor: model presenterActionResult ]
]

{ #category : #initialization }
PWBMooseModelBrowser >> initializePresenterFor: aCollection [
	| listPresenter listPresenterMenu |
	listPresenterMenu := self newMenu.
	listPresenter := self newList.
	listPresenter
		items: aCollection;
		beMultipleSelection;
		display: [ :item | item name ];
		icons: [ :each | each systemIcon ];
		sortingBlock: [ :a :b | a numberOfLinesOfCode > b numberOfLinesOfCode ];
		enableItemSubstringFilter;
		contextMenu: listPresenterMenu.
	listPresenter
		whenSelectionChangedDo: [ :selected | 
			model selected: (FamixTypeGroup withAll: listPresenter selectedItems).
			listPresenterMenu defaultGroup menuItems removeAll.
			self subMenu: listPresenter.
			self needRebuild: false.
			self buildWithSpec ].
	^ listPresenter
]

{ #category : #initialization }
PWBMooseModelBrowser >> initializePresenters [
	super initializePresenters.
	model := PWBMooseModelBrowserModel new.
	model pwbBrowser: self.
	self initializeMilerModelPresenter.
	self initializeTable.
	self initializeSearchField.
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
	menu := self newMenu.
	modelPresenter := self newList.
	modelPresenter
		beMultipleSelection;
		display: [ :item | item name ];
		icons: [ :each | each systemIcon ];
		sortingBlock: [ :a :b | a methods asSet size > b methods asSet size ];
		enableItemSubstringFilter;
		contextMenu: menu.
	modelPresenter
		whenSelectionChangedDo: [ :selected | 
			model selected: (FamixTypeGroup withAll: modelPresenter selectedItems).
			AbstractBrowserSenderMode actionFor: self.
			menu defaultGroup menuItems removeAll.
			self subMenu.
			self needRebuild: false.
			self buildWithSpec ]
]

{ #category : #'accessing ' }
PWBMooseModelBrowser >> isPropagate [
	^ propagateButton state
]

{ #category : #accessing }
PWBMooseModelBrowser >> millerModelPresenter [
	^ millerModelPresenter
]

{ #category : #accessing }
PWBMooseModelBrowser >> millerModelPresenter: anObject [
	millerModelPresenter := anObject
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
	millerModelPresenter
		setRootModel: model pwbMooseModel asOrderedCollection.
	self needRebuild: false.
	self buildWithSpec
]

{ #category : #initialization }
PWBMooseModelBrowser >> subMenu [
	| pwbContextMenu |
	modelPresenter selectedItems ifEmpty: [ ^ self newMenu ].
	pwbContextMenu := AbstractPWBContextMenu
		pwbContextMenu: modelPresenter selectedItems anyOne.
	pwbContextMenu entities: modelPresenter selectedItems.
	pwbContextMenu presenterModel: model.
	pwbContextMenu actions
		do: [ :action | 
			menu
				addItem: [ :item | 
					item
						name: action asString;
						action: [ pwbContextMenu perform: action ] ];
				yourself ]
]

{ #category : #initialization }
PWBMooseModelBrowser >> subMenu: aPresenter [
	| pwbContextMenu |
	aPresenter selectedItems ifEmpty: [ ^ self newMenu ].
	pwbContextMenu := AbstractPWBContextMenu
		pwbContextMenu: aPresenter selectedItems anyOne.
	pwbContextMenu entities: aPresenter selectedItems.
	pwbContextMenu presenterModel: model.
	pwbContextMenu actions
		do: [ :action | 
			aPresenter contextMenu
				addItem: [ :item | 
					item
						name: action asString;
						action: [ pwbContextMenu perform: action ] ];
				yourself ]
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
