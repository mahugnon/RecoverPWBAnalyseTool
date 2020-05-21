Class {
	#name : #PWBNewTagForm,
	#superclass : #SpPresenter,
	#instVars : [
		'newTagName',
		'colorPalete',
		'saveButton',
		'entity'
	],
	#category : #'PowerBuilderAnalyzeTool-CallGraphBrowser-TagForm'
}

{ #category : #specs }
PWBNewTagForm class >> defaultSpec [
	^ SpBoxLayout newVertical
		add: #newTagName
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
	saveButton
		action: [ newTagName input text isEmpty
				ifTrue: [ ^ self ].
			(FAMIXTag named: newTagName input text)
				mooseModel: entity mooseModel;
				color: colorPalete selectedColor.
			entity mooseModel resetTags.
			self owner closeTagForm.
			self owner update ]
]

{ #category : #accessing }
PWBNewTagForm >> entity: aFamixPWBUserObject [ 
	entity := aFamixPWBUserObject
]

{ #category : #initialization }
PWBNewTagForm >> initializePresenters [
	newTagName := self instantiate: SpLabelledTextInput.
	newTagName label: 'Tag name: '.
	colorPalete := self instantiate: PWBColorPalette.
	saveButton := self newButton
		label: 'Save';
		iconName: #glamorousAccept;
		yourself
]
