Class {
	#name : #CIMIzyFilesNavigator,
	#superclass : #SpPresenter,
	#instVars : [
		'model',
		'listPresenter',
		'selectedBib',
		'rootFolder',
		'space',
		'resetButton',
		'runModelButton',
		'modulesFolderButton'
	],
	#category : #'PowerBuilderAnalyzeTool-Utils-FileSystemNavigation'
}

{ #category : #specs }
CIMIzyFilesNavigator class >> defaultSpec [
	^ SpBoxLayout newVertical
		add:
			(SpBoxLayout newHorizontal
				add: #space;
				add: #rootFolder;
				add: #modulesFolderButton;
				yourself)
			withConstraints: [ :constraints | constraints height: self toolbarHeight ];
		add: #listPresenter;
		add:
			(SpBoxLayout newHorizontal
				add: #space;
				add:
					(SpBoxLayout newHorizontal
						add: #resetButton;
						add: #runModelButton;
						yourself);
				yourself)
			withConstraints: [ :constraints | constraints height: self toolbarHeight ];
		yourself
]

{ #category : #specs }
CIMIzyFilesNavigator class >> runMe [
	<script>
	^ self new openWithSpec
]

{ #category : #initialization }
CIMIzyFilesNavigator >> connectPresenters [
	rootFolder
		action: [ model
				izyProtectRootFolder: (UITheme builder chooseDirectory: 'Choose izy protect source files') ].
	modulesFolderButton
		action: [ model
				moduleFolder: (UITheme builder chooseDirectory: 'Choose Modules folder') ]
]

{ #category : #initialization }
CIMIzyFilesNavigator >> initializePresenters [
	super initializePresenters.
	modulesFolderButton := self newButton
		label: 'set modules folder';
		iconName: #smallOpen;
		yourself.
	space := self newLabel
		color: Color transparent;
		yourself.
	resetButton := self newButton
		label: 'Reset';
		yourself.
	runModelButton := self newButton
		label: 'Run model';
		yourself.
	rootFolder := self newButton
		label: 'set Izy source folder';
		iconName: #smallOpen;
		yourself.
	selectedBib := OrderedCollection new.
	model := CIMIzyFilesNavigatorModel new.
	model browser: self.
	listPresenter := self newTable.
	listPresenter
		enableSearch;
		addColumn:
			((SpCheckBoxTableColumn
				title: ' '
				evaluated: [ :bib | selectedBib includes: bib ])
				onActivation: [ :bib | selectedBib add: bib ];
				onDesactivation: [ :bib | selectedBib remove: bib ];
				width: 20;
				yourself);
		addColumn: (SpStringTableColumn title: 'Bibliotheque' evaluated: #yourself);
		items: model bibliotheques asOrderedCollection;
		beResizable
]

{ #category : #initialization }
CIMIzyFilesNavigator >> setItems [
	listPresenter items: model bibliotheques asOrderedCollection
]
