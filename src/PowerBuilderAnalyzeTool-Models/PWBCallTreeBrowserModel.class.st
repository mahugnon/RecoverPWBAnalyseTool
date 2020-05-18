Class {
	#name : #PWBCallTreeBrowserModel,
	#superclass : #PWBAbstractModel,
	#instVars : [
		'selectionListeners',
		'selectedMethodsInvocationsSendersParents'
	],
	#category : #'PowerBuilderAnalyzeTool-Models'
}

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
PWBCallTreeBrowserModel >> selectedMethodsInvocationsSendersTypes [
	^ selected methodsInvocationsSendersTypes asOrderedCollection
]

{ #category : #initialization }
PWBCallTreeBrowserModel >> setContent [
	selected content ifNil: [ selected setContent ]
]
