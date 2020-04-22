Class {
	#name : #BrowserModePropagate,
	#superclass : #AbstractBrowserSenderMode,
	#category : #'PowerBuilderAnalyzeTool-Utils-BrowserMode'
}

{ #category : #'as yet unclassified' }
BrowserModePropagate class >> mode: aBrowser [
	^ aBrowser isPropagate
]

{ #category : #'target resize' }
BrowserModePropagate >> applyOn: aBrowser [
	^ aBrowser propagateAction
]
