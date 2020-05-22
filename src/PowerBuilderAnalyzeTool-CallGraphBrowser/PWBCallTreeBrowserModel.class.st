Class {
	#name : #PWBCallTreeBrowserModel,
	#superclass : #PWBAbstractModel,
	#instVars : [
		'selectionListeners',
		'selectedMethodsInvocationsSendersParents'
	],
	#category : #'PowerBuilderAnalyzeTool-CallGraphBrowser-Model'
}

{ #category : #'as yet unclassified' }
PWBCallTreeBrowserModel >> actionsCategory [
	^ #Actions
]

{ #category : #'as yet unclassified' }
PWBCallTreeBrowserModel >> actionsTags [
	| mooseModel |
	mooseModel := selected mooseModel.
	^ ([ mooseModel findTagCategoryNamed: self actionsCategory ]
		on: NotFound
		do: [ mooseModel createTagCategoryNamed: self actionsCategory ])
		markedTags
]

{ #category : #api }
PWBCallTreeBrowserModel >> globallySelect: anEntity [
	pwbBrowser globallySelect: anEntity
]

{ #category : #accessing }
PWBCallTreeBrowserModel >> pwbBrowser: aPWBBrowser [
	pwbBrowser := aPWBBrowser
]

{ #category : #api }
PWBCallTreeBrowserModel >> refreshWithParameters: anOptionParameters [
	selectedMethodsInvocationsSendersParents := (QueryIncomingInvocationSenders
		options: anOptionParameters) runOn: selected.
	pwbBrowser updateRoassal
]

{ #category : #api }
PWBCallTreeBrowserModel >> roassal [
	^ selected roassalPresenter
]

{ #category : #accessing }
PWBCallTreeBrowserModel >> selected: anObject [
	selected := anObject isCollection
		ifTrue: [ anObject anyOne ]
		ifFalse: [ anObject ]
]

{ #category : #initialization }
PWBCallTreeBrowserModel >> selectedContent [
	selected ifNil: [ selected setContent ].
	^ selected content
]

{ #category : #initialization }
PWBCallTreeBrowserModel >> selectedMethodsInvocationsSendersParents [
	selectedMethodsInvocationsSendersParents
		ifNil: [ selectedMethodsInvocationsSendersParents := selected
				incomingInvocationsSenders: 1
				exceptFromMethodsOfType: #() ].
	^ selectedMethodsInvocationsSendersParents
]

{ #category : #api }
PWBCallTreeBrowserModel >> selectedMethodsInvocationsSendersTypes [
	^ selected methodsInvocationsSendersTypes asOrderedCollection
]

{ #category : #initialization }
PWBCallTreeBrowserModel >> setContent [
	selected content ifNil: [ selected setContent ]
]
