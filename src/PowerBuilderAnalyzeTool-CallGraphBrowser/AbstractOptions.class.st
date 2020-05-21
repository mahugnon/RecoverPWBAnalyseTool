Class {
	#name : #AbstractOptions,
	#superclass : #Object,
	#category : #'PowerBuilderAnalyzeTool-CallGraphBrowser-EntityFilterOptions'
}

{ #category : #'as yet unclassified' }
AbstractOptions class >> optionName [
	^ self subclassResponsibility
]

{ #category : #'target resize' }
AbstractOptions >> applyOn: aBrowser [
	self subclassResponsibility
]
