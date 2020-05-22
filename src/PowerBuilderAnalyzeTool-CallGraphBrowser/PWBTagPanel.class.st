Class {
	#name : #PWBTagPanel,
	#superclass : #SpPresenter,
	#instVars : [
		'form'
	],
	#category : #'PowerBuilderAnalyzeTool-CallGraphBrowser-TagForm'
}

{ #category : #initialization }
PWBTagPanel >> initializePresenter [
	form := self instantiate: PWBTagForm
]

{ #category : #initialization }
PWBTagPanel >> openNewTagForm [
	form := self instantiate: PWBNewTagForm.
	self update
]

{ #category : #initialization }
PWBTagPanel >> openTagForm [
	form := self instantiate: PWBTagForm
]
