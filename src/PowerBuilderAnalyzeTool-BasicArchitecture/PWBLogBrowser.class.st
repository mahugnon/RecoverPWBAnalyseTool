Class {
	#name : #PWBLogBrowser,
	#superclass : #PWBAbstractBrowser,
	#instVars : [
		'logsPresenter',
		'exportButton'
	],
	#category : #'PowerBuilderAnalyzeTool-BasicArchitecture-Browser'
}

{ #category : #specs }
PWBLogBrowser class >> defaultSpec [
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
PWBLogBrowser class >> runMe [
	<script>
	self new openWithSpec
]

{ #category : #visiting }
PWBLogBrowser >> accept: anObject [
	^ true
]

{ #category : #initialization }
PWBLogBrowser >> connectPresenters [ 
]

{ #category : #api }
PWBLogBrowser >> followAction [
	self needRebuild: false.
	self buildWithSpec
]

{ #category : #api }
PWBLogBrowser >> highlightAction [
	self needRebuild: false.
	self buildWithSpec
]

{ #category : #initialization }
PWBLogBrowser >> initializePresenters [
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
PWBLogBrowser >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		whenClosedDo: [ self application windowClosed: aWindowPresenter ].
	aWindowPresenter
		title: self title;
		initialExtent: 400 @ 300
]

{ #category : #accessing }
PWBLogBrowser >> logger [
	^ self application logger
]

{ #category : #TOREMOVE }
PWBLogBrowser >> title [
^'Log Browser'
]
