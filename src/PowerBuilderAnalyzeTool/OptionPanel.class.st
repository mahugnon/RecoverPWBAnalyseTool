Class {
	#name : #OptionPanel,
	#superclass : #PWBPresenter,
	#instVars : [
		'possibleEntities',
		'optionParameters',
		'maxLevel',
		'validateButton',
		'paramPresenter',
		'cancel',
		'browser',
		'options',
		'possibleEntitiesPresenter',
		'typesPresenter'
	],
	#classVars : [
		'uniqueInstance'
	],
	#category : #'PowerBuilderAnalyzeTool-Core'
}

{ #category : #'as yet unclassified' }
OptionPanel class >> browser: aBrower possibleEntities: aCollection1 updateTypesPresenter: aCollection2 [
	uniqueInstance hasWindow
		ifTrue: [ uniqueInstance window close ].
	uniqueInstance
		browser: aBrower
		possibleEntities: aCollection1
		updateTypesPresenter: aCollection2.
	uniqueInstance openWithSpec
]

{ #category : #specs }
OptionPanel class >> defaultSpec [
	^ SpBoxLayout newVertical
		add:
			(SpBoxLayout newHorizontal
				add: #options;
				yourself)
			withConstraints: [ :constraints | 
				constraints
					height: self toolbarHeight;
					width: self buttonWidth;
					expand: false ];
		add: #paramPresenter;
		add:
			(SpBoxLayout newHorizontal
				add: #validateButton;
				add: #cancel;
				yourself)
			withConstraints: [ :constraints | 
				constraints
					height: self toolbarHeight;
					expand: false ];
		yourself
]

{ #category : #'class initialization' }
OptionPanel class >> initialize [
	uniqueInstance := self new
]

{ #category : #examples }
OptionPanel class >> runMe [
	<script>
	self new openWithSpec
]

{ #category : #accessing }
OptionPanel >> browser: aPWBBrowser [
	browser := aPWBBrowser
]

{ #category : #'as yet unclassified' }
OptionPanel >> browser: aBrowser possibleEntities: aCollection1 updateTypesPresenter: aCollection2 [
	self
		browser: aBrowser;
		possibleEntities: aCollection1;
		updateTypesPresenter: aCollection2
]

{ #category : #initialization }
OptionPanel >> connectPresenters [
	options whenSelectedItemChangedDo: [ :item | item new applyOn: self ]
]

{ #category : #'as yet unclassified' }
OptionPanel >> filterConsideredMethodTypeAction [
paramPresenter := typesPresenter.
	self needRebuild: false.
	^ self buildWithSpec
]

{ #category : #initialization }
OptionPanel >> initializeMaxLevel [
	maxLevel := self newTextInput.
	maxLevel
		autoAccept: true;
		placeholder: 'set max level'.
]

{ #category : #initialization }
OptionPanel >> initializeOptions [
	options := self newDropList.
	options
		items: AbstractOptions subclasses;
		display: [ :e | e optionName ];
		selectItem: InvocationAtLevelOption
]

{ #category : #initialization }
OptionPanel >> initializePossibleEntitiesPresenter [
	possibleEntitiesPresenter := self newTable.
	possibleEntitiesPresenter
		addColumn:
			((SpCheckBoxTableColumn
				title: ' '
				evaluated: [ :entity | optionParameters selectedEntities includes: entity ])
				onActivation: [ :entity | optionParameters addEntity: entity ];
				onDesactivation: [ :entity | optionParameters removeEntities: entity ];
				width: 20;
				yourself);
		addColumn: (SpStringTableColumn title: 'Entities' evaluated: #name).
	possibleEntitiesPresenter enableItemSubstringFilter
]

{ #category : #initialization }
OptionPanel >> initializePresenters [
	possibleEntities := OrderedCollection new.
	optionParameters := OptionParameters new.
self initializeOptions.
	self initializePossibleEntitiesPresenter.
	self initializeTypesPresenter.
	self initializeMaxLevel.
	validateButton := self newButton.
	validateButton
		label: 'Validate';
		iconName: #smallOk;
		action: [ self validate ].
	cancel := self newButton
		label: 'Close';
		action: [ self window close ];
		iconName: #changeRemove;
		yourself.
	paramPresenter := maxLevel
]

{ #category : #initialization }
OptionPanel >> initializeTypesPresenter [
	typesPresenter := self newTable.
	typesPresenter
		addColumn:
			((SpCheckBoxTableColumn
				title: ' '
				evaluated:
					[ :aFamixBehaviour | optionParameters typeToFilter includes: aFamixBehaviour ])
				onActivation:
						[ :aFamixBehaviour | optionParameters addTypeToFilter: aFamixBehaviour ];
				onDesactivation:
						[ :aFamixBehaviour | optionParameters removeTypeToFilters: aFamixBehaviour ];
				width: 20;
				yourself);
		addColumn: (SpStringTableColumn title: 'Type' evaluated: #name).
	typesPresenter enableItemSubstringFilter
]

{ #category : #initialization }
OptionPanel >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		whenClosedDo: [ self application windowClosed: aWindowPresenter ].
	aWindowPresenter
		title: self title;
		initialExtent: 300 @ 200
]

{ #category : #'as yet unclassified' }
OptionPanel >> invocationAtLevelAction [
paramPresenter := maxLevel.
	self needRebuild: false.
	^ self buildWithSpec
]

{ #category : #'as yet unclassified' }
OptionPanel >> invocationWithEntitiesAction [
	paramPresenter := possibleEntitiesPresenter.
	self needRebuild: false.
	^ self buildWithSpec
]

{ #category : #accessing }
OptionPanel >> maxLevel [
	^ maxLevel
]

{ #category : #accesing }
OptionPanel >> optionParameters [
	^ optionParameters
]

{ #category : #accessing }
OptionPanel >> options [
	^ options
]

{ #category : #access }
OptionPanel >> paramPresenter [
	^ paramPresenter
]

{ #category : #accessing }
OptionPanel >> possibleEntities: aCollection [
	possibleEntities := aCollection.
	possibleEntitiesPresenter items: possibleEntities
]

{ #category : #accessing }
OptionPanel >> possibleEntitiesPresenter [
	^ possibleEntitiesPresenter
]

{ #category : #TOREMOVE }
OptionPanel >> title [ 
^'Options'
]

{ #category : #'as yet unclassified' }
OptionPanel >> updateTypesPresenter: aCollection [
	typesPresenter items: aCollection
]

{ #category : #'private actions' }
OptionPanel >> validate [
	optionParameters
		action: options selectedItem;
		maxLevel: (maxLevel text asInteger ifNil: [ 1 ]).
	browser ifNotNil: [ browser refreshWithParameters: optionParameters ]
]
