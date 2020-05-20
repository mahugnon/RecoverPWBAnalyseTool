Class {
	#name : #PWBSourceTextBrowserModel,
	#superclass : #PWBAbstractModel,
	#category : #'PowerBuilderAnalyzeTool-Models'
}

{ #category : #accessing }
PWBSourceTextBrowserModel >> selected: anObject [
	selected := anObject
]

{ #category : #accessing }
PWBSourceTextBrowserModel >> sourceText [
	self halt.
	^ selected sourceText
]
