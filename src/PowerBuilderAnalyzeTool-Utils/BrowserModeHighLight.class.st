Class {
	#name : #BrowserModeHighLight,
	#superclass : #AbstractBrowserReceiverMode,
	#category : #'PowerBuilderAnalyzeTool-Utils-BrowserMode'
}

{ #category : #'as yet unclassified' }
BrowserModeHighLight class >> mode: aBrowser [
	^ aBrowser isHighlight
]

{ #category : #'target resize' }
BrowserModeHighLight >> applyOn: aBrowser [
	^ aBrowser highlightAction
]
