Class {
	#name : #PWBTagForm,
	#superclass : #PWBAbstractBrowser,
	#instVars : [
		'entity',
		'tagsList',
		'newTagName',
		'colorPalete',
		'newTagForm',
		'addNewTag'
	],
	#category : #'PowerBuilderAnalyzeTool-CallGraphBrowser-TagForm'
}

{ #category : #specs }
PWBTagForm class >> defaultSpec [
	^ SpBoxLayout newVertical
		add:
			(SpBoxLayout newHorizontal
				add: #tagsList;
				add: #addNewTag;
				yourself)
			withConstraints: [ :constraints | constraints height: self toolbarHeight ];
		add: #newTagForm;
		yourself
]

{ #category : #examples }
PWBTagForm class >> runMe [
	<script>
	self new open
]

{ #category : #api }
PWBTagForm class >> tag: anObject [
	^ self new
		entity: anObject;
		open
]

{ #category : #visiting }
PWBTagForm >> accept: anObject [
	^ true
]

{ #category : #api }
PWBTagForm >> closeTagForm [
	addNewTag state: false
]

{ #category : #initialization }
PWBTagForm >> connectPresenters [
	addNewTag
		whenChangedDo: [ self needRebuild: false.
			self buildWithSpec ]
]

{ #category : #accessing }
PWBTagForm >> entity [
	^ entity
]

{ #category : #accessing }
PWBTagForm >> entity: anObject [
	entity := anObject.
	newTagForm entity: entity.
	tagsList items: entity mooseModel allTags
]

{ #category : #api }
PWBTagForm >> followAction [
	
]

{ #category : #api }
PWBTagForm >> highlightAction [
	
]

{ #category : #initialization }
PWBTagForm >> initializePresenters [
	addNewTag := self newCheckBox.
	addNewTag label: 'Add new  tag'.
	addNewTag state: false.
	tagsList := self newDropList.
	tagsList display: [ :each | each name ].
	"tagsList label: 'Select a Tag: '."
	newTagForm := self instantiate: PWBNewTagForm.
	newTagForm visibleIf: [ addNewTag state ]
]

{ #category : #initialization }
PWBTagForm >> initializeWindow: aWindowPresenter [
	super initializeWindow: aWindowPresenter.
	aWindowPresenter initialExtent: 500 @ 300
]

{ #category : #'instance creation' }
PWBTagForm >> open [
	self openDialogWithSpec
]

{ #category : #accessing }
PWBTagForm >> selectEntity: anEntity [
	entity := anEntity.
	tagsList items: entity mooseModel allTags asOrderedCollection
]

{ #category : #accessing }
PWBTagForm >> tagsList [
	^ tagsList
]
