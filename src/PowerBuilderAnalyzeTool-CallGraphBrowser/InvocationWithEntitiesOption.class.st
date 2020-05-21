Class {
	#name : #InvocationWithEntitiesOption,
	#superclass : #AbstractOptions,
	#category : #'PowerBuilderAnalyzeTool-CallGraphBrowser-EntityFilterOptions'
}

{ #category : #'as yet unclassified' }
InvocationWithEntitiesOption class >> optionName [
	^ 'InvocationWithEntitiesOption'
]

{ #category : #'target resize' }
InvocationWithEntitiesOption >> applyOn: aBrowser [
	aBrowser invocationWithEntitiesAction
]
