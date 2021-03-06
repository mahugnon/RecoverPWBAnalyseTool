Class {
	#name : #PWBDuplicationBrowser,
	#superclass : #PWBAbstractBrowser,
	#instVars : [
		'duplicationResultPanel',
		'duplicationViewSelector',
		'minNumberOfLinesTextInput',
		'minNumberOfCharactersInput',
		'okButton',
		'browseListButton',
		'detectorsDropDown',
		'detectorsDropDownLabel'
	],
	#classInstVars : [
		'colorMap'
	],
	#category : #'PowerBuilderAnalyzeTool-DuplicationBrowser-Browser'
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
				add:
					(SpBoxLayout newHorizontal
						add: #detectorsDropDownLabel;
						add: #detectorsDropDown;
						yourself);
				add: #okButton
					withConstraints: [ :constraints | constraints width: self buttonWidth ];
				yourself)
			withConstraints: [ :constraints | constraints height: self toolbarHeight ];
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
PWBDuplicationBrowser class >> scriptToExportDuplicationsOfSomePWBObjects [
	<example>
	| objectNames userObjects methods param duplicationFragments exporter |
	self flag: #ToImprove.
	objectNames := {'uo_traitement_liq_cal' . 'w_liquidation_saisie'.
	'uo_traitement_liq_noe' . 'w_liquidation_pec'}.
	userObjects := MooseModel root first allModelEntities
		select: [ :e | 
			(FamixPWBmajorObject subclasses includes: e class)
				and: [ objectNames includes: e name ] ].
	methods := userObjects
		flatCollect: [ :obj | obj methods reject: #isNoisyMethod ].
	param := DPParameters new
		minNumberOfLines: 20;
		frequency: 2;
		minNumberOfCharacters: 160;
		cleaner: DPPWBCleaner new.
	duplicationFragments := DuplicationStrategy new
		runOn: methods
		with: param.
	exporter := PWBDuplicationListBrowser new.
	exporter model pwbMooseModel: duplicationFragments.
	exporter model exportToCSV.
	exporter model exportToCSV1
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
	FamixTypeGroup. FamixPWBWindow } includes: anObject class
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
			self buildWithSpec ].
	detectorsDropDown
		whenSelectedItemChangedDo: [ :selection | model detector: selection ]
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
		action: [ PWBDuplicationListBrowser openWith: model duplicationFragments ]
]

{ #category : #initialization }
PWBDuplicationBrowser >> initializeDetectorsDropDown [
	detectorsDropDown := self newDropList.
	detectorsDropDown
		items: model detectors;
		display: [ :each | each pwbName ].
	detectorsDropDown selectItem: model detector.
	detectorsDropDownLabel := self newLabel
		label: 'Detectors';
		yourself
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
				label: 'Min character:'
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
	okButton := self newLink
		label: 'Run';
		iconNamed: #glamorousPlay;
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
	self initializeBrowseListButton.
	self initializeDetectorsDropDown
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

{ #category : #initialization }
PWBDuplicationBrowser >> pwbExtent [
	^ 800 @ 450
]

{ #category : #specs }
PWBDuplicationBrowser >> title [
^'Code duplication browser '
]
