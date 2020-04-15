Class {
	#name : #AbstractBrowserMode,
	#superclass : #Object,
	#category : #'PowerBuilderAnalyzeTool-Utils-BrowserMode'
}

{ #category : #'as yet unclassified' }
AbstractBrowserMode class >> actionFor: aBrowser [
	^ (self subclasses detect: [ :aStrategy | aStrategy mode: aBrowser ])
		new applyOn: aBrowser
]

{ #category : #'as yet unclassified' }
AbstractBrowserMode class >> mode: aBrowser [
	^ self subclassResponsibility
]

{ #category : #'target resize' }
AbstractBrowserMode >> applyOn: aBrowser [
	^ self subclassResponsibility
]
