Class {
	#name : #PWBTagForm,
	#superclass : #PWBAbstractBrowser,
	#instVars : [
		'tagsList',
		'newTagName',
		'colorPalete',
		'newTagForm',
		'addNewTagButton',
		'shape',
		'saveButton',
		'cancelButton'
	],
	#category : #'PowerBuilderAnalyzeTool-CallGraphBrowser-TagForm'
}

{ #category : #specs }
PWBTagForm class >> defaultSpec [
	^ SpBoxLayout newVertical
		add:
			(SpBoxLayout newHorizontal
				add: #tagsList;
				add:
					(SpPanedLayout newHorizontal
						position: 100;
						add: #addNewTagButton;
						yourself);
				yourself)
			withConstraints: [ :constraints | constraints height: self toolbarHeight ];
		add: #newTagForm;
		add:
			(SpPanedLayout newHorizontal
				position: 200;
				add:
					(SpBoxLayout newHorizontal
						add: #saveButton;
						add: #cancelButton;
						yourself)
					withConstraints: [ :constraints | 
						constraints
							beNotResizable;
							beNotShrinkable ];
				yourself)
			withConstraints: [ :constraints | constraints height: self toolbarHeight ];
		yourself
]

{ #category : #examples }
PWBTagForm class >> runMe [
	<script>
	self new openWithSpec
]

{ #category : #api }
PWBTagForm class >> tag: anObject [
	^ self new
		shape: anObject;
		openWithSpec
]

{ #category : #visiting }
PWBTagForm >> accept: anObject [
	^ true
]

{ #category : #initialization }
PWBTagForm >> cancelTagEntityAction [
	self window close
]

{ #category : #api }
PWBTagForm >> closeTagForm [
	newTagForm := self newNullPresenter.
	addNewTagButton enable.
	self initializeSaveCancelButtons.
	self
		resize: self initialSize;
		update
]

{ #category : #initialization }
PWBTagForm >> connectPresenters [
	addNewTagButton whenChangedDo: [ self update ]
]

{ #category : #accessing }
PWBTagForm >> entity [
	^ shape model
]

{ #category : #api }
PWBTagForm >> followAction [
	
]

{ #category : #api }
PWBTagForm >> highlightAction [
	
]

{ #category : #initialization }
PWBTagForm >> initialSize [
	^ 230 @ 110
]

{ #category : #initialization }
PWBTagForm >> initializeAddNewTagButton [
	addNewTagButton := self newButton
		label: 'New Tag';
		iconName: #smallAdd;
		action:
				[ self newTagButtonAction ]
]

{ #category : #initialization }
PWBTagForm >> initializeNewTagForm [
	newTagForm := self newNullPresenter
]

{ #category : #initialization }
PWBTagForm >> initializePresenters [
	self initializeSaveCancelButtons.
	self initializeAddNewTagButton.
	self initializeTagsList.
	self initializeNewTagForm
]

{ #category : #initialization }
PWBTagForm >> initializeSaveCancelButtons [
	saveButton := self newButton
		label: 'Tag entity';
		iconName: #testGreen;
		action: [ self tagEntityAction ];
		yourself.
	cancelButton := self newButton
		label: 'Cancel';
		iconName: #testRed;
		action: [ self cancelTagEntityAction ];
		yourself
]

{ #category : #initialization }
PWBTagForm >> initializeTagsList [
	tagsList := self instantiate: SpLabelledDropList.
	tagsList display: [ :each | each name ].
	tagsList label: 'Tags:'
]

{ #category : #initialization }
PWBTagForm >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter
		initialExtent: self initialSize;
		title: 'Tag Form'
]

{ #category : #initialization }
PWBTagForm >> newTagButtonAction [
	addNewTagButton disable.
	saveButton := self newNullPresenter.
	cancelButton := self newNullPresenter.
	self resize: self newTagFormSize.
	newTagForm := self instantiate: PWBNewTagForm.
	newTagForm entity: self entity.
	self update
]

{ #category : #initialization }
PWBTagForm >> newTagFormSize [
	^ 700 @ 600
]

{ #category : #initialization }
PWBTagForm >> resize: aPoint [
	self window extent: aPoint
]

{ #category : #accessing }
PWBTagForm >> selectEntity: anEntity [

]

{ #category : #accessing }
PWBTagForm >> shape [
	^ shape
]

{ #category : #accessing }
PWBTagForm >> shape: aRSShape [
	shape := aRSShape.
	tagsList items: aRSShape model mooseModel tags
]

{ #category : #initialization }
PWBTagForm >> tagEntityAction [
	tagsList selectedItem tagEntity: self entity.
	shape color: (ColorObject colorFor: self entity).
	self cancelTagEntityAction
]

{ #category : #accessing }
PWBTagForm >> tagsList [
	^ tagsList
]
