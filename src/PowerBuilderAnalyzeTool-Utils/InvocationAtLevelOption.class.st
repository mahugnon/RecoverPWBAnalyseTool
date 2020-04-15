Class {
	#name : #InvocationAtLevelOption,
	#superclass : #AbstractOptions,
	#category : #'PowerBuilderAnalyzeTool-Utils-CallTreeOptions'
}

{ #category : #'as yet unclassified' }
InvocationAtLevelOption class >> optionName [
	^ 'InvocationAtLevelOption'
]

{ #category : #'target resize' }
InvocationAtLevelOption >> applyOn: aBrowser [
	aBrowser invocationAtLevelAction
]
