Class {
	#name : #PWBCallTreeBrowser,
	#superclass : #PWBAbstractBrowser,
	#instVars : [
		'diagramPresenter',
		'uselessFunctionButton',
		'browseDuplicationButton',
		'obsoleteVarButton',
		'optionPanel',
		'optionPanelCurrentWindow'
	],
	#category : #'PowerBuilderAnalyzeTool-Browsers'
}

{ #category : #utility }
PWBCallTreeBrowser class >> createIcon [
	ThemeIcons
		compile:
			'callTreeContents
	^ '''
				,
					(Base64MimeConverter
						mimeEncode:
							'/Users/honore/Downloads/function.png' asFileReference
								binaryReadStream) contents , ''''
		classified: '*PowerBuilderAnalyzeTool'.
	ThemeIcons
		compile:
			'callGraphIcon
	^ icons
			at: #''callGraphIcon''
			ifAbsentPut:[ Form fromBinaryStream: self callTreeContents base64Decoded asByteArray readStream ]'
		classified: '*PowerBuilderAnalyzeTool'.
	Smalltalk ui icons callGraphIcon
]

{ #category : #specs }
PWBCallTreeBrowser class >> defaultSpec [
	^ super defaultSpec
		add:
			(SpBoxLayout newHorizontal
				add: #browseDuplicationButton;
				add: #obsoleteVarButton;
				add: #optionPanel;
				yourself)
			withConstraints: [ :constraints | constraints height: self toolbarHeight ];
		add: #diagramPresenter;
		yourself
]

{ #category : #running }
PWBCallTreeBrowser class >> run [
  < example>
  ^self new openWithSpec
]

{ #category : #visiting }
PWBCallTreeBrowser >> accept: anEntity [
	^ ({DPFragmentLocation.
	FamixPWBFunction.
	UndefinedObject} includes: anEntity class) not
		and: [ anEntity size = 1 ]
]

{ #category : #api }
PWBCallTreeBrowser >> followAction [
	(self needUpdate: toSelect)
		ifFalse: [ ^ self ].
	self model selected: toSelect.
	self updateRoassal
]

{ #category : #api }
PWBCallTreeBrowser >> highlightAction [
	((self needUpdate: toSelect) and: [ self accept: toSelect ])
		ifFalse: [ ^ self ].
	diagramPresenter highlight: toSelect
]

{ #category : #initialization }
PWBCallTreeBrowser >> initializeBrowserModel [
	model := PWBCallTreeBrowserModel new.
	model pwbBrowser: self
]

{ #category : #initialization }
PWBCallTreeBrowser >> initializePresenters [
	super initializePresenters.
	self initializeBrowserModel.
	self initializeRoassal.
	self initializeToolBar.

]

{ #category : #initialization }
PWBCallTreeBrowser >> initializeRoassal [
	diagramPresenter := self newLabel.
	diagramPresenter label: 'Visualization here'
]

{ #category : #initialization }
PWBCallTreeBrowser >> initializeToolBar [
	obsoleteVarButton := self newButton
		label: 'Browse obsolete Var';
		help: 'Browse non referenced varables';
		iconName: #halt;
		action: [ PWBNonUsedVariableBrowser new
				selectEntity: model selected;
				openWithSpec ].
	browseDuplicationButton := self newButton
		label: 'Browse duplication';
		help: 'Browse duplication between functions.';
		icon: PWBBrowserIcons duplicationIcon;
		action: [ PWBDuplicationBrowser lunchOn: model selected ].
	optionPanel := self newButton.
	optionPanel
		label: 'Options';
		icon: PWBBrowserIcons option;
		action: [ OptionPanel
				browser: self
				possibleEntities: model selectedMethodsInvocationsSendersParents
				updateTypesPresenter: model selectedMethodsInvocationsSendersTypes ]
]

{ #category : #initialization }
PWBCallTreeBrowser >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter initialExtent: 750 @ 500
]

{ #category : #api }
PWBCallTreeBrowser >> refreshWithParameters: anOptionParameters [
	model refreshWithParameters: anOptionParameters.
	
]

{ #category : #'accessing ' }
PWBCallTreeBrowser >> selected: aFamixPWBUserObject [
	model selected: aFamixPWBUserObject
]

{ #category : #accessing }
PWBCallTreeBrowser >> title [
^'PWBObject Invocations Tree Browser'
]

{ #category : #api }
PWBCallTreeBrowser >> updateRoassal [
	diagramPresenter := self instantiate: model roassal.
	diagramPresenter guiModel: model.
	self needRebuild: false.
	self buildWithSpec
]
