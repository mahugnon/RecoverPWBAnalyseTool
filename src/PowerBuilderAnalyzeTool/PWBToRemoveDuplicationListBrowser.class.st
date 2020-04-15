Class {
	#name : #PWBToRemoveDuplicationListBrowser,
	#superclass : #PWBAbstractBrowser,
	#instVars : [
		'list',
		'exportButton'
	],
	#category : #'PowerBuilderAnalyzeTool-Browsers'
}

{ #category : #specs }
PWBToRemoveDuplicationListBrowser class >> defaultSpec [
	^ super defaultSpec
		add: #exportButton
			withConstraints: [ :constraints | constraints height: self toolbarHeight ];
		add: #list;
		yourself
]

{ #category : #initialization }
PWBToRemoveDuplicationListBrowser class >> openWith: aCollection [
	| view |
	view := self new.
	view model pwbMooseModel: aCollection.
	view openWithSpec
]

{ #category : #specs }
PWBToRemoveDuplicationListBrowser class >> runMe [
	<script>
	self new openWithSpec
]

{ #category : #visiting }
PWBToRemoveDuplicationListBrowser >> accept: anObject [
	
]

{ #category : #initialization }
PWBToRemoveDuplicationListBrowser >> initializePWBToRemoveDuplicationListBrowserModel [
	model := PWBToRemoveDuplicationListBrowserModel new.
	model pwbBrowser: self
]

{ #category : #initialization }
PWBToRemoveDuplicationListBrowser >> initializePresenters [
	super initializePresenters.
	list := self newList.
	list
		headerTitle: '             Selection Dupplicated functions list       ';
		display: [ :each | each parentType name , ' >> ' , each name ];
		sortingBlock: [ :a :b | a mooseName < b mooseName ].
	exportButton := self newButton.
	exportButton label: 'Export'.
	exportButton action: [ model exportToCSV ].
	self initializePWBToRemoveDuplicationListBrowserModel
]

{ #category : #accessing }
PWBToRemoveDuplicationListBrowser >> selectEntity: anEntity [
	
]

{ #category : #TOREMOVE }
PWBToRemoveDuplicationListBrowser >> title [ 
^'Liste of Duplicated entities'
]

{ #category : #updating }
PWBToRemoveDuplicationListBrowser >> update [
	list items: model pwbMooseModel keys.
	super update
]
