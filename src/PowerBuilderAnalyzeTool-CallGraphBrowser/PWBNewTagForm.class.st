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
		'addTagCategory'
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
		add: #saveButton
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
PWBNewTagForm >> connectPresenters [
	newCategoryButton
		action: [ addTagCategory := categoriesForm.
			self update ].
	saveButton
		action: [ newTagName input text isEmpty
				ifTrue: [ ^ self ].
			(entity mooseModel createTagNamed: newTagName input text)
				addCategory: tagCategories selectedItem;
				color: colorPalete selectedColor.
			self owner closeTagForm.
			self owner update ].
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
PWBNewTagForm >> initializePresenters [
	newTagName := self instantiate: SpLabelledTextInput.
	newTagName label: 'Tag name: '.
	colorPalete := self instantiate: PWBColorPalette.
	saveButton := self newButton
		label: 'Save';
		iconName: #glamorousAccept;
		yourself.
	tagCategories := self instantiate: SpLabelledDropList.
	tagCategories label: 'Categories:'.
	categoriesForm := self instantiate: SpLabelledTextInput.
	categoriesForm label: 'Category name:'.
	newCategoryButton := self newButton
		label: 'addTag';
		yourself.
	addTagCategory := newCategoryButton
]

{ #category : #accessing }
PWBNewTagForm >> tagCategories: aMooseModel [
	tagCategories items: aMooseModel allTagCategories.
	self update
]
