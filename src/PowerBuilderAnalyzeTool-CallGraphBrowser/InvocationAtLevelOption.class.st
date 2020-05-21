Class {
	#name : #InvocationAtLevelOption,
	#superclass : #AbstractOptions,
	#category : #'PowerBuilderAnalyzeTool-CallGraphBrowser-EntityFilterOptions'
}

{ #category : #'as yet unclassified' }
InvocationAtLevelOption class >> optionName [
	^ 'InvocationAtLevelOption'
]

{ #category : #'target resize' }
InvocationAtLevelOption >> applyOn: aBrowser [
	aBrowser invocationAtLevelAction
]
