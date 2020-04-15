Class {
	#name : #PWBNonUsedFunctionBrowserModel,
	#superclass : #PWBAbstractModel,
	#category : #'PowerBuilderAnalyzeTool-Models'
}

{ #category : #accessing }
PWBNonUsedFunctionBrowserModel >> refreshPwbMooseModel [
	pwbMooseModel := QueryDeadMethods runOn: selected
]

{ #category : #accessing }
PWBNonUsedFunctionBrowserModel >> selected: anObject [
	selected := anObject.
	self refreshPwbMooseModel
]
