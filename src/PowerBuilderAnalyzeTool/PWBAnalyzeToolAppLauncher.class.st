Class {
	#name : #PWBAnalyzeToolAppLauncher,
	#superclass : #PWBPresenter,
	#instVars : [
		'callTreeBrowser',
		'callTreeBrowserLabel',
		'duplicationBrowser',
		'duplicationBrowserLabel',
		'mooseModelBrowser',
		'mooseModelBrowserLabel',
		'sourceTextBrowser',
		'sourceTextBrowserLabel',
		'logBrowser',
		'logBrowserLabel'
	],
	#category : #'PowerBuilderAnalyzeTool-Core'
}

{ #category : #specs }
PWBAnalyzeToolAppLauncher class >> defaultSpec [
	^ SpBoxLayout newHorizontal
		add:
			(SpBoxLayout newVertical
				add: #duplicationBrowserLabel;
				add: #mooseModelBrowser;
				yourself);
		add:
			(SpBoxLayout newVertical
				add: #duplicationBrowserLabel;
				add: #duplicationBrowser;
				yourself);
		add:
			(SpBoxLayout newVertical
				add: #callTreeBrowserLabel;
				add: #callTreeBrowser;
				yourself);
		add:
			(SpBoxLayout newVertical
				add: #sourceTextBrowserLabel;
				add: #sourceTextBrowser;
				yourself);
		add:
			(SpBoxLayout newVertical
				add: #logBrowserLabel;
				add: #logBrowser;
				yourself);
		yourself
]

{ #category : #'as yet unclassified' }
PWBAnalyzeToolAppLauncher class >> lunchPWBAnalyzeToolOn: aBuilder [
	<worldMenu>
	(aBuilder item: #PWBAnalyzeTool)
		order: 10;
		help:
			'Lauch call Powerbuider methods call tree. You should install a PowerbuilderMooseModel in the image';
		label: 'PWBAnalyzeTool';
		icon: PWBBrowserIcons pwbAnalyzeTool;
		action: [ self runMe ]
]

{ #category : #examples }
PWBAnalyzeToolAppLauncher class >> runMe [
	<script>
	self new openWithSpec
]

{ #category : #initialization }
PWBAnalyzeToolAppLauncher >> initializeCallTreeBrowserLuncher [
	callTreeBrowser := self newButton
		icon: PWBBrowserIcons callTreeLogo;
		action: [ PWBCallTreeBrowser run ];
		help: 'Open the call graph browser'.
	callTreeBrowserLabel := self newLabel label: 'Call Graph Browser'
]

{ #category : #initialization }
PWBAnalyzeToolAppLauncher >> initializeDuplicationBrowserLuncher [
	duplicationBrowser := self newButton
		icon: PWBBrowserIcons duplicationLogo;
		action: [ PWBDuplicationBrowser runMe ];
		help: 'Open the duplication browser'.
	duplicationBrowserLabel := self newLabel label: 'Duplication Browser'
]

{ #category : #initialization }
PWBAnalyzeToolAppLauncher >> initializeLogBrowserLuncher [
	logBrowser := self newButton
		icon: PWBBrowserIcons loggerLogo;
		action: [ PWBLogBrower runMe ];
		help: 'Open activity logs'.
	logBrowserLabel := self newLabel label: 'Logs Browser'
]

{ #category : #initialization }
PWBAnalyzeToolAppLauncher >> initializeMooseModelBrowserLauncher [
	mooseModelBrowser := self newButton
		icon: PWBBrowserIcons mooseModelLogo;
		action: [ PWBMooseModelBrowser runMe ];
		help: 'Open the Source code FamixModel Browser'.
	mooseModelBrowserLabel := self newLabel label: 'Model Browser'
]

{ #category : #initialization }
PWBAnalyzeToolAppLauncher >> initializePresenters [
	self initializeDuplicationBrowserLuncher.
	self initializeCallTreeBrowserLuncher.
	self initializeMooseModelBrowserLauncher.
	self initializeSourceTextBrowserLauncher.
	self initializeLogBrowserLuncher
]

{ #category : #initialization }
PWBAnalyzeToolAppLauncher >> initializeSourceTextBrowserLauncher [
	sourceTextBrowser := self newButton
		icon: PWBBrowserIcons sourceTextLogo;
		action: [ PWBSourceTextBrowser runMe ];
		help: 'Open the source code Browser'.
	sourceTextBrowserLabel := self newLabel label: 'Source code Browser'
]

{ #category : #initialization }
PWBAnalyzeToolAppLauncher >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter whenClosedDo: [ self application close .
		PWBApplication reset ].
	aWindowPresenter
		title: self title;
		initialExtent: 600 @ 150;
		isResizeable: false
]

{ #category : #initialization }
PWBAnalyzeToolAppLauncher >> title [
^'PWBAnalyzeTool Launcher'
]
