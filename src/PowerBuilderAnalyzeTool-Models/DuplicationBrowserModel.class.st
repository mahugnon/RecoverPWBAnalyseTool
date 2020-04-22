Class {
	#name : #DuplicationBrowserModel,
	#superclass : #PWBAbstractModel,
	#instVars : [
		'duplicationFragments',
		'duplicationView',
		'selectedFragmentLocation',
		'colorMap',
		'focusClonedFragment',
		'duplicationEntities',
		'fragmentColors',
		'minNumberOfLines',
		'minNumberOfCharacters'
	],
	#category : #'PowerBuilderAnalyzeTool-Models'
}

{ #category : #api }
DuplicationBrowserModel >> addFragment: anObject color: aColor [
  colorMap at: anObject entity put: aColor.
  duplicationView updateView
]

{ #category : #private }
DuplicationBrowserModel >> colorFor: anObject [
	self initializeColors.
	^ fragmentColors keys
		detect: [ :each | anObject isMemberOf: (fragmentColors at: each) ]
		ifNone: [ Color gray ]
]

{ #category : #accessing }
DuplicationBrowserModel >> computeDuplication [
	self computeDuplicationWith: self mooseModelFunctions
]

{ #category : #initialization }
DuplicationBrowserModel >> computeDuplicationWith: aCollection [
	| param |
	param := DPParameters new
		minNumberOfLines: minNumberOfLines;
		frequency: 2;
		minNumberOfCharacters: minNumberOfCharacters;
		cleaner: DPPWBCleaner new.
	duplicationFragments := QueryDuplication new
		runOn: aCollection
		with: param.
	self refreshRoassal
]

{ #category : #api }
DuplicationBrowserModel >> defaultRoassalView [
	^ DuplicationBrowserRoassalViewByEntity
]

{ #category : #initialization }
DuplicationBrowserModel >> duplicationEntities [
	| dpLocations |
	dpLocations := self duplicationLocations.
	duplicationEntities := dpLocations groupedBy: #entity.
	^ duplicationEntities
]

{ #category : #accessing }
DuplicationBrowserModel >> duplicationFragments [
	^ duplicationFragments
]

{ #category : #accessing }
DuplicationBrowserModel >> duplicationFragments: anObject [
	duplicationFragments := anObject
]

{ #category : #initialization }
DuplicationBrowserModel >> duplicationLocations [
  ^duplicationFragments flatCollectAsSet: #members
]

{ #category : #accessing }
DuplicationBrowserModel >> duplicationView [
	^ duplicationView
]

{ #category : #accessing }
DuplicationBrowserModel >> duplicationView: anObject [
	duplicationView := anObject
]

{ #category : #accessing }
DuplicationBrowserModel >> focusClonedFragment [
	^ selectedFragmentLocation clonedFragment
]

{ #category : #initialization }
DuplicationBrowserModel >> initialize [
	super initialize.
	pwbMooseModel := #().
	duplicationFragments := OrderedCollection new.
	colorMap := OrderedDictionary new.
	selectedFragmentLocation := DPFragmentLocation new.
	minNumberOfLines := 20.
	minNumberOfCharacters := 160
]

{ #category : #initialization }
DuplicationBrowserModel >> initializeColors [
	fragmentColors ifNil: [ fragmentColors := Dictionary new ]
]

{ #category : #accessing }
DuplicationBrowserModel >> minNumberOfCharacters [
	^ minNumberOfCharacters
]

{ #category : #accessing }
DuplicationBrowserModel >> minNumberOfCharacters: anInteger [ 
	minNumberOfCharacters := anInteger
]

{ #category : #accessing }
DuplicationBrowserModel >> minNumberOfLines [
	^ minNumberOfLines
]

{ #category : #accessing }
DuplicationBrowserModel >> minNumberOfLines: anInteger [ 
	minNumberOfLines := anInteger
]

{ #category : #accessing }
DuplicationBrowserModel >> mooseModel: aFamixPWBUserObject [
	pwbMooseModel := aFamixPWBUserObject.
	self traceCr: 'set ' , aFamixPWBUserObject name , ' as pwbMooseModel'.
	self computeDuplication
]

{ #category : #api }
DuplicationBrowserModel >> mooseModelFunctions [
	^ (pwbMooseModel flatCollect: #methods) asSet
]

{ #category : #initialization }
DuplicationBrowserModel >> refreshRoassal [
  duplicationView updateView
]

{ #category : #accessing }
DuplicationBrowserModel >> selected: anObject [
	selected := anObject asOrderedCollection
]

{ #category : #accessing }
DuplicationBrowserModel >> selectedFragmentLocation: anObject [
	selectedFragmentLocation := anObject.
	self selected: anObject
]

{ #category : #api }
DuplicationBrowserModel >> updateFragmentColorFor: aFamixPWBFunction [
	| fragment |
	fragment := ((duplicationEntities at: aFamixPWBFunction)
		collect: #clonedFragment) asOrderedCollection.
	fragmentColors := OrderedDictionary
		newFromKeys: (Color wheel: fragment size)
		andValues: fragment asOrderedCollection.
	^ fragmentColors
]
