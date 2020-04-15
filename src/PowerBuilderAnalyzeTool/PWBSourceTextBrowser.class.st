Class {
	#name : #PWBSourceTextBrowser,
	#superclass : #PWBAbstractBrowser,
	#instVars : [
		'sourceText',
		'noteBook',
		'sourceCodePage'
	],
	#category : #'PowerBuilderAnalyzeTool-Browsers'
}

{ #category : #specs }
PWBSourceTextBrowser class >> defaultSpec [
	^ super defaultSpec
		add: #noteBook;
		yourself
]

{ #category : #examples }
PWBSourceTextBrowser class >> runMe [
	<script>
	self new openWithSpec
]

{ #category : #visiting }
PWBSourceTextBrowser >> accept: anObject [
	^ {FamixPWBUserObject.
	FamixPWBBehavioral.
	DPFragmentLocation} includes: anObject class
]

{ #category : #initialization }
PWBSourceTextBrowser >> entityName: aString [
	sourceCodePage title: aString , ' source code'
]

{ #category : #initialization }
PWBSourceTextBrowser >> initializePresenters [
	super initializePresenters.
	model := PWBSourceTextBrowserModel new.
	sourceText := self newText.
	noteBook := self newNotebook.
	self sourceCodePage.
	noteBook addPage: sourceCodePage
]

{ #category : #accessing }
PWBSourceTextBrowser >> selectEntity: anEntity [
	self isFreeze
		ifTrue: [ ^ self ].
	(self needUpdate: anEntity)
		ifFalse: [ ^ self ].
	model selected: anEntity.
	self updateCode
]

{ #category : #initialization }
PWBSourceTextBrowser >> sourceCodePage [
	sourceCodePage := SpNotebookPage
		title: 'Source code'
		icon: (self iconNamed: #nautilusIcon)
		provider: [ sourceText ]
]

{ #category : #accessing }
PWBSourceTextBrowser >> text: aText [
  sourceText text: aText
]

{ #category : #TOREMOVE }
PWBSourceTextBrowser >> title [ 
^'Source code Browser'
]

{ #category : #updating }
PWBSourceTextBrowser >> updateCode [
	self text: model sourceText.
	self entityName: model selected name
]
