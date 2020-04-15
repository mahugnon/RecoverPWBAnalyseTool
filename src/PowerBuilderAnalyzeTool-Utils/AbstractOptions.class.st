Class {
	#name : #AbstractOptions,
	#superclass : #Object,
	#category : #'PowerBuilderAnalyzeTool-Utils-CallTreeOptions'
}

{ #category : #'as yet unclassified' }
AbstractOptions class >> optionName [
	^ self subclassResponsibility
]

{ #category : #'target resize' }
AbstractOptions >> applyOn: aBrowser [
	self subclassResponsibility
]
