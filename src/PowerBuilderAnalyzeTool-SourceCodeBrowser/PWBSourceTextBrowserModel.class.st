Class {
	#name : #PWBSourceTextBrowserModel,
	#superclass : #PWBAbstractModel,
	#category : #'PowerBuilderAnalyzeTool-SourceCodeBrowser-Model'
}

{ #category : #accessing }
PWBSourceTextBrowserModel >> selected: anObject [
	selected := anObject
]

{ #category : #accessing }
PWBSourceTextBrowserModel >> sourceText [
	^ selected sourceText
]
