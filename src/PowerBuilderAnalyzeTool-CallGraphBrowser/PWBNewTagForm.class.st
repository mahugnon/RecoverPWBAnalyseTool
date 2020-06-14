Class {
	#name : #PWBNewTagForm,
	#superclass : #SpPresenter,
	#instVars : [
		'newTagName',
		'colorPalete',
		'saveButton',
		'entity',
		'tagCategories',
		'categoriesForm',
		'newCategoryButton',
		'addTagCategory',
		'cancelButton',
		'size'
	],
	#category : #'PowerBuilderAnalyzeTool-CallGraphBrowser-TagForm'
}

{ #category : #specs }
PWBNewTagForm class >> defaultSpec [
	^ SpBoxLayout newVertical
		add:
			(SpBoxLayout newHorizontal
				add: #tagCategories;
				add: #addTagCategory;
				add: #newTagName;
				yourself)
			withConstraints: [ :constraints | constraints height: self toolbarHeight ];
		add: #colorPalete;
		add:
			(SpPanedLayout newHorizontal
				position: 250;
				add:
					(SpBoxLayout newHorizontal
						add: #saveButton;
						add: #cancelButton;
						yourself);
				yourself)
			withConstraints: [ :constraints | 
				constraints
					height: self buttonHeight;
					width: self buttonWidth ];
		yourself
]

{ #category : #examples }
PWBNewTagForm class >> runMe [
	<script>
	self new openWithSpec
]

{ #category : #initialization }
PWBNewTagForm >> close [
	self owner closeTagForm
]

{ #category : #initialization }
PWBNewTagForm >> connectPresenters [
	categoriesForm
		whenTextIsAccepted: [ :text | 
			entity mooseModel createTagCategoryNamed: text.
			addTagCategory := newCategoryButton.
			self update ]
]

{ #category : #accessing }
PWBNewTagForm >> entity: aFamixPWBUserObject [
	entity := aFamixPWBUserObject.
	self tagCategories: entity mooseModel
]

{ #category : #initialization }
PWBNewTagForm >> initializeAddTagCategory [
	addTagCategory := newCategoryButton
]

{ #category : #initialization }
PWBNewTagForm >> initializeCancelButton [
	cancelButton := self newButton
		label: 'Cancel';
		iconName: #glamorousCancel;
		yourself.
	cancelButton action: [ self close ]
]

{ #category : #initialization }
PWBNewTagForm >> initializeCategoriesForm [
	categoriesForm := self instantiate: SpLabelledTextInput.
	categoriesForm label: 'Category name:'
]

{ #category : #initialization }
PWBNewTagForm >> initializeColorPalette [
	colorPalete := self instantiate: PWBColorPalette
]

{ #category : #initialization }
PWBNewTagForm >> initializeNewCategoryButton [
	newCategoryButton := self newButton
		label: 'New Category';
		iconName: #smallAdd;
		yourself.
	newCategoryButton
		action: [ addTagCategory := categoriesForm.
			self update ]
]

{ #category : #initialization }
PWBNewTagForm >> initializeNewTagName [
	newTagName := self instantiate: SpLabelledTextInput.
	newTagName label: 'Tag name: '
]

{ #category : #initialization }
PWBNewTagForm >> initializePresenters [
	self initializeNewTagName.
	self initializeColorPalette.
	self initializeSaveButton.
	self initializeCancelButton.
	self initializeTagCategories.
	self initializeCategoriesForm.
	self initializeNewCategoryButton.
	self initializeAddTagCategory
]

{ #category : #initialization }
PWBNewTagForm >> initializeSaveButton [
	saveButton := self newButton
		label: 'Save';
		iconName: #glamorousAccept;
		yourself.
	saveButton
		action: [ newTagName input text isEmpty
				ifTrue: [ ^ self ].
			(entity mooseModel createTagNamed: newTagName input text)
				addCategory: tagCategories selectedItem;
				color: colorPalete selectedColor.
			self close ]
]

{ #category : #initialization }
PWBNewTagForm >> initializeTagCategories [
	tagCategories := self instantiate: SpLabelledDropList.
	tagCategories
		label: 'Categories:';
		display: [ :cat | cat name ]
]

{ #category : #accessing }
PWBNewTagForm >> tagCategories: aMooseModel [
	tagCategories items: aMooseModel allTagCategories.
	self update
]
