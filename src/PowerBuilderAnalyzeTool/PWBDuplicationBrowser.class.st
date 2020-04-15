Class {
	#name : #PWBDuplicationBrowser,
	#superclass : #PWBAbstractBrowser,
	#instVars : [
		'duplicationResultPanel',
		'duplicationViewSelector',
		'minNumberOfLinesTextInput',
		'minNumberOfCharactersInput',
		'okButton',
		'browseListButton'
	],
	#classInstVars : [
		'colorMap'
	],
	#category : #'PowerBuilderAnalyzeTool-Browsers'
}

{ #category : #private }
PWBDuplicationBrowser class >> createIcon [
	ThemeIcons
		compile:
			'duplicationIcon
	^ '''
				,
					(Base64MimeConverter
						mimeEncode:
							'/Users/honore/Documents/Resources/duplicate.png' asFileReference
								binaryReadStream) contents , ''''
		classified: '*PowerBuilderAnalyzeTool'.
	ThemeIcons
		compile:
			'duplication
	^ icons
			at: #''duplication''
			ifAbsentPut:[ Form fromBinaryStream: self duplicationIcon base64Decoded asByteArray readStream ]'
		classified: 'PowerBuilderAnalyzeTool'.
	Smalltalk ui icons duplication
]

{ #category : #specs }
PWBDuplicationBrowser class >> defaultSpec [
	^ super defaultSpec
		add:
			(SpBoxLayout newVertical
				add:
					(SpBoxLayout newHorizontal
						add: #duplicationViewSelector;
						add: #browseListButton;
						yourself)
					withConstraints: [ :constraints | constraints height: self toolbarHeight ];
				add: #duplicationResultPanel;
				yourself);
		add:
			(SpBoxLayout newHorizontal
				add: #minNumberOfLinesTextInput;
				add: #minNumberOfCharactersInput;
				add: #okButton;
				yourself)
			withConstraints: [ :constraints | 
				constraints
					height: self buttonHeight;
					width: self buttonWidth ];
		yourself
]

{ #category : #'as yet unclassified' }
PWBDuplicationBrowser class >> lunchOn: anObject [
	self new
		mooseModel: anObject;
		openWithSpec
]

{ #category : #examples }
PWBDuplicationBrowser class >> runMe [
  < example>
  self new openWithSpec
]

{ #category : #'as yet unclassified' }
PWBDuplicationBrowser class >> testLunchOn: anObject [
	^ self basicNew
		initializeModel;
		mooseModel: anObject;
		initialize;
		selectFirstItem
]

{ #category : #visiting }
PWBDuplicationBrowser >> accept: anObject [
	^ {FamixPWBUserObject.
	FAMIXTypeGroup. FamixPWBWindow } includes: anObject class
]

{ #category : #initialization }
PWBDuplicationBrowser >> connectPresenters [
	super connectPresenters.
	minNumberOfLinesTextInput
		whenTextChangedDo: [ :aText | model minNumberOfLines: aText asInteger ].
	minNumberOfCharactersInput
		whenTextChangedDo: [ :aText | model minNumberOfCharacters: aText asInteger ].
	duplicationViewSelector
		whenSelectedItemChangedDo: [ :selection | 
			duplicationResultPanel := self instantiate: selection.
			duplicationResultPanel model: model.
			self needRebuild: false.
			self buildWithSpec ]
]

{ #category : #accessing }
PWBDuplicationBrowser >> followAction [
	((self accept: toSelect) and: [ self needUpdate: toSelect ])
		ifFalse: [ ^ self ].
	model mooseModel: toSelect
]

{ #category : #api }
PWBDuplicationBrowser >> highlightAction [
	((self needUpdate: toSelect) and: [ self accept: toSelect ])
		ifFalse: [ ^ self ].
	duplicationResultPanel highlight: toSelect
]

{ #category : #initialization }
PWBDuplicationBrowser >> initializeBrowseListButton [
	browseListButton := self newButton.
	browseListButton label: 'Browser list'.
	browseListButton
		action: [ PWBToRemoveDuplicationListBrowser
				openWith: model duplicationEntities ]
]

{ #category : #initialization }
PWBDuplicationBrowser >> initializeDuplicationResultPanel [
	duplicationResultPanel := self instantiate: model defaultRoassalView.
	duplicationResultPanel model: model
]

{ #category : #initialization }
PWBDuplicationBrowser >> initializeDuplicationRoassalViewSelector [
	duplicationViewSelector := self newDropList.
	duplicationViewSelector
		items: DuplicationBrowserRoassalView views;
		help: 'Select the roassal visualization to use';
		display: [ :item | item viewName ];
		selectItem: DuplicationBrowserRoassalViewByEntity
]

{ #category : #initialization }
PWBDuplicationBrowser >> initializeMinNumberOfCharactersInput [
	minNumberOfCharactersInput := self
		instantiate:
			(SpLabelledPresenter
				label: 'Min character: '
				input:
					(self newTextInput
						autoAccept: true;
						placeholder: 'Fill the minimum character of dupplicated lines to return';
						text: self minNumberOfCharacters asString))
]

{ #category : #initialization }
PWBDuplicationBrowser >> initializeMinNumberOfLinesTextInput [
	minNumberOfLinesTextInput := self
		instantiate:
			(SpLabelledPresenter
				label: 'Min line: '
				input:
					(self newTextInput
						autoAccept: true;
						placeholder: 'Fill the minimum number of dupplicated lines to return';
						text: self minNumberOfLines asString))
]

{ #category : #initialization }
PWBDuplicationBrowser >> initializeModel [
	model := DuplicationBrowserModel new.
	model pwbBrowser: self
]

{ #category : #initialization }
PWBDuplicationBrowser >> initializeOkButton [
	okButton := self newButton
		label: 'Do it';
		iconName: #glamorousPlay;
		action: [ model computeDuplication ];
		yourself
]

{ #category : #initialization }
PWBDuplicationBrowser >> initializePresenters [
	super initializePresenters.
	self initializeModel.
	self initializeDuplicationResultPanel.
	self initializeDuplicationRoassalViewSelector.
	self initializeMinNumberOfLinesTextInput.
	self initializeMinNumberOfCharactersInput.
	self initializeOkButton.
	self initializeBrowseListButton
]

{ #category : #accessing }
PWBDuplicationBrowser >> minNumberOfCharacters [
	^ model minNumberOfCharacters
]

{ #category : #accessing }
PWBDuplicationBrowser >> minNumberOfCharactersInput [
	^ minNumberOfCharactersInput
]

{ #category : #accessing }
PWBDuplicationBrowser >> minNumberOfLines [
	^ model minNumberOfLines
]

{ #category : #acessing }
PWBDuplicationBrowser >> minNumberOfLinesTextInput [
	^ minNumberOfLinesTextInput
]

{ #category : #accessing }
PWBDuplicationBrowser >> mooseModel: aFamixPWBUserObject [
	model mooseModel: aFamixPWBUserObject
]

{ #category : #specs }
PWBDuplicationBrowser >> title [
^'Code duplication browser '
]
