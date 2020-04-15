Class {
	#name : #InvocationWithEntitiesOption,
	#superclass : #AbstractOptions,
	#category : #'PowerBuilderAnalyzeTool-Utils-CallTreeOptions'
}

{ #category : #'as yet unclassified' }
InvocationWithEntitiesOption class >> optionName [
	^ 'InvocationWithEntitiesOption'
]

{ #category : #'target resize' }
InvocationWithEntitiesOption >> applyOn: aBrowser [
	aBrowser invocationWithEntitiesAction
]
