Class {
	#name : #PWBDuplicationListBrowser,
	#superclass : #PWBAbstractBrowser,
	#instVars : [
		'list',
		'exportButton'
	],
	#category : #'PowerBuilderAnalyzeTool-DuplicationBrowser-Browser'
}

{ #category : #specs }
PWBDuplicationListBrowser class >> defaultSpec [
	^ super defaultSpec
		add: #exportButton
			withConstraints: [ :constraints | constraints height: self toolbarHeight ];
		add: #list;
		yourself
]

{ #category : #initialization }
PWBDuplicationListBrowser class >> openWith: aCollection [
	| view |
	view := self new.
	view model pwbMooseModel: aCollection.
	view openWithSpec
]

{ #category : #specs }
PWBDuplicationListBrowser class >> runMe [
	<script>
	self new openWithSpec
]

{ #category : #visiting }
PWBDuplicationListBrowser >> accept: anObject [
	
]

{ #category : #initialization }
PWBDuplicationListBrowser >> initializeDuplicationListBrowserModel [
	model := PWBDuplicationListBrowserModel new.
	model pwbBrowser: self
]

{ #category : #initialization }
PWBDuplicationListBrowser >> initializePresenters [
	super initializePresenters.
	list := self newList.
	list
		headerTitle: '             Selection Dupplicated functions list       ';
		display: [ :each | 
			| members |
			members := each members.
			String
				streamContents: [ :stream | 
					1 to: members size - 1 do: [ :iter | 
						| member |
						member := members at: iter.
						stream
							<< member name;
							<< ' (';
							<< member startLine asString;
							<< '->';
							<< member endLine asString;
							<< '  );' ].
					stream
						<< members last name;
						<< ' (';
						<< members last startLine asString;
						<< '->';
						<< members last endLine asString;
						<< '  )' ] ];
		sortingBlock: [ :a :b | a mooseName < b mooseName ].
	exportButton := self newButton.
	exportButton label: 'Export'.
	exportButton action: [ model exportToCSV ].
	self initializeDuplicationListBrowserModel
]

{ #category : #accessing }
PWBDuplicationListBrowser >> selectEntity: anEntity [
	
]

{ #category : #TOREMOVE }
PWBDuplicationListBrowser >> title [ 
^'Liste of Duplicated entities'
]

{ #category : #updating }
PWBDuplicationListBrowser >> update [
	list items: model pwbMooseModel.
	super update
]
