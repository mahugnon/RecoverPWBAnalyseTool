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
		'logBrowserLabel',
		'deadMethodBrowser',
		'deadMethodBrowserLabel'
	],
	#category : #'PowerBuilderAnalyzeTool-Launcher'
}

{ #category : #specs }
PWBAnalyzeToolAppLauncher class >> browserIconConstraint [
	^ [ :constraints | 
	constraints
		height: PWBBrowserIcons logoHeight;
		expand: false ]
]

{ #category : #specs }
PWBAnalyzeToolAppLauncher class >> browserIconWithLabelConstraint [
	^ [ :constraints | 
	constraints
		height: PWBBrowserIcons logoHeight + self labelHeight;
		expand: false ]
]

{ #category : #specs }
PWBAnalyzeToolAppLauncher class >> defaultSpec [
	^ SpBoxLayout newHorizontal
		spacing: 10;
		add:
			(SpBoxLayout newVertical
				add: #mooseModelBrowserLabel expand: false;
				add: #mooseModelBrowser
					withConstraints: self browserIconConstraint;
				yourself)
			withConstraints: self browserIconWithLabelConstraint;
		add:
			(SpBoxLayout newVertical
				add: #deadMethodBrowserLabel expand: false;
				add: #deadMethodBrowser
					withConstraints: self browserIconConstraint;
				yourself)
			withConstraints: self browserIconWithLabelConstraint;
		add:
			(SpBoxLayout newVertical
				add: #duplicationBrowserLabel expand: false;
				add: #duplicationBrowser
					withConstraints: self browserIconConstraint;
				yourself)
			withConstraints: self browserIconWithLabelConstraint;
		add:
			(SpBoxLayout newVertical
				add: #callTreeBrowserLabel expand: false;
				add: #callTreeBrowser withConstraints: self browserIconConstraint;
				yourself)
			withConstraints: self browserIconWithLabelConstraint;
		add:
			(SpBoxLayout newVertical
				add: #sourceTextBrowserLabel expand: false;
				add: #sourceTextBrowser
					withConstraints: self browserIconConstraint;
				yourself)
			withConstraints: self browserIconWithLabelConstraint;
		add:
			(SpBoxLayout newVertical
				add: #logBrowserLabel expand: false;
				add: #logBrowser withConstraints: self browserIconConstraint;
				yourself)
			withConstraints: self browserIconWithLabelConstraint;
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
	callTreeBrowserLabel := self newLabel label: 'Call Graph'
]

{ #category : #initialization }
PWBAnalyzeToolAppLauncher >> initializeDeadMethodsBrowserLuncher [
	deadMethodBrowser := self newButton
		icon: PWBBrowserIcons deadMethodLogo;
		action: [ PWBDeadMethodsBrowser run ];
		help: 'Open the dead methods browser'.
	deadMethodBrowserLabel := self newLabel label: 'Dead Methods'
]

{ #category : #initialization }
PWBAnalyzeToolAppLauncher >> initializeDuplicationBrowserLuncher [
	duplicationBrowser := self newButton
		icon: PWBBrowserIcons duplicationLogo;
		action: [ PWBDuplicationBrowser runMe ];
		help: 'Open the duplication browser'.
	duplicationBrowserLabel := self newLabel label: 'Duplication'
]

{ #category : #initialization }
PWBAnalyzeToolAppLauncher >> initializeLogBrowserLuncher [
	logBrowser := self newButton
		icon: PWBBrowserIcons loggerLogo;
		action: [ PWBLogBrower runMe ];
		help: 'Open activity logs'.
	logBrowserLabel := self newLabel label: 'Logs'
]

{ #category : #initialization }
PWBAnalyzeToolAppLauncher >> initializeMooseModelBrowserLauncher [
	mooseModelBrowser := self newButton
		icon: PWBBrowserIcons mooseModelLogo;
		action: [ PWBMooseModelBrowser runMe ];
		help: 'Open the Source code FamixModel Browser'.
	mooseModelBrowserLabel := self newLabel label: 'Model'
]

{ #category : #initialization }
PWBAnalyzeToolAppLauncher >> initializePresenters [
	self initializeDuplicationBrowserLuncher.
	self initializeCallTreeBrowserLuncher.
	self initializeMooseModelBrowserLauncher.
	self initializeSourceTextBrowserLauncher.
	self initializeDeadMethodsBrowserLuncher.
	self initializeLogBrowserLuncher
]

{ #category : #initialization }
PWBAnalyzeToolAppLauncher >> initializeSourceTextBrowserLauncher [
	sourceTextBrowser := self newButton
		icon: PWBBrowserIcons sourceTextLogo;
		action: [ PWBSourceTextBrowser runMe ];
		help: 'Open the source code Browser'.
	sourceTextBrowserLabel := self newLabel label: 'Source code'
]

{ #category : #initialization }
PWBAnalyzeToolAppLauncher >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter isResizeable: false.
	aWindowPresenter color: Color lightBlue.
	aWindowPresenter
		whenClosedDo: [ self application close.
			PWBApplication reset ].
	aWindowPresenter
		title: self title;
		initialExtent: 550 @ 120;
		isResizeable: false
]

{ #category : #initialization }
PWBAnalyzeToolAppLauncher >> title [
^'PWBAnalyzeTool Launcher'
]
