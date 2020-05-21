Class {
	#name : #PWBLogBrower,
	#superclass : #PWBAbstractBrowser,
	#instVars : [
		'logsPresenter',
		'exportButton'
	],
	#category : #'PowerBuilderAnalyzeTool-LogBrowser'
}

{ #category : #specs }
PWBLogBrower class >> defaultSpec [
	^ SpBoxLayout newVertical
		add:
			(SpPanedLayout newHorizontal
				position: 60;
				add: #exportButton;
				yourself)
			withConstraints: [ :constraints | 
				constraints
					height: self toolbarHeight;
					expand: false ];
		add: #logsPresenter;
		yourself
]

{ #category : #examples }
PWBLogBrower class >> runMe [
	<script>
	self new openWithSpec
]

{ #category : #visiting }
PWBLogBrower >> accept: anObject [
	^ true
]

{ #category : #initialization }
PWBLogBrower >> connectPresenters [ 
]

{ #category : #api }
PWBLogBrower >> followAction [
	self needRebuild: false.
	self buildWithSpec
]

{ #category : #api }
PWBLogBrower >> highlightAction [
	self needRebuild: false.
	self buildWithSpec
]

{ #category : #initialization }
PWBLogBrower >> initializePresenters [
	super initializePresenters.
	logsPresenter := self newList.
	logsPresenter
		items: self logger logs;
		"	display: [ :elt | 
			elt printString.
			self halt ];"
			sortingBlock: [ :a :b | a time > b time ];
		headerTitle: '             Activity Logs       '.
	exportButton := self newButton
		iconName: #glamorousSaveToUrl;
		label: 'Export';
		yourself
]

{ #category : #initialization }
PWBLogBrower >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		whenClosedDo: [ self application windowClosed: aWindowPresenter ].
	aWindowPresenter
		title: self title;
		initialExtent: 400 @ 300
]

{ #category : #accessing }
PWBLogBrower >> logger [
	^ self application logger
]

{ #category : #TOREMOVE }
PWBLogBrower >> title [
^'Log Browser'
]
