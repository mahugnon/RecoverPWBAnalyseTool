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
	newCategoryButton
		action: [ addTagCategory := categoriesForm.
			self update ].
	saveButton
		action: [ newTagName input text isEmpty
				ifTrue: [ ^ self ].
			(entity mooseModel createTagNamed: newTagName input text)
				addCategory: tagCategories selectedItem;
				color: colorPalete selectedColor.
			self close ].
	cancelButton action: [ self close ].
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
	cancelButton := self newButton
		label: 'Cancel';
		iconName: #glamorousCancel;
		yourself.
	tagCategories := self instantiate: SpLabelledDropList.
	tagCategories label: 'Categories:'.
	categoriesForm := self instantiate: SpLabelledTextInput.
	categoriesForm label: 'Category name:'.
	newCategoryButton := self newButton
		label: 'New Category';
		yourself.
	addTagCategory := newCategoryButton
]

{ #category : #accessing }
PWBNewTagForm >> tagCategories: aMooseModel [
	tagCategories items: aMooseModel allTagCategories.
	self update
]
