Class {
	#name : #PWBDeadMethodsBrowserModel,
	#superclass : #PWBAbstractModel,
	#category : #'PowerBuilderAnalyzeTool-Models'
}

{ #category : #accessing }
PWBDeadMethodsBrowserModel >> selected: anObject [
	selected := anObject.
pwbMooseModel := QueryDeadMethods runOn: selected
]
