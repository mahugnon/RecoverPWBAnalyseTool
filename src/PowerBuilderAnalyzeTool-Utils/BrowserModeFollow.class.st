Class {
	#name : #BrowserModeFollow,
	#superclass : #AbstractBrowserReceiverMode,
	#category : #'PowerBuilderAnalyzeTool-Utils-BrowserMode'
}

{ #category : #visiting }
BrowserModeFollow class >> mode: aBrowser [
	^ aBrowser isFollow
]

{ #category : #'target resize' }
BrowserModeFollow >> applyOn: aBrowser [
	^ aBrowser followAction
]
