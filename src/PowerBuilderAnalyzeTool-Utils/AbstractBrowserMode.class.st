Class {
	#name : #AbstractBrowserMode,
	#superclass : #Object,
	#category : #'PowerBuilderAnalyzeTool-Utils-BrowserMode'
}

{ #category : #api }
AbstractBrowserMode class >> actionFor: aBrowser [
	^ self subclasses
		detect: [ :aStrategy | aStrategy mode: aBrowser ]
		ifFound: [ :founded | founded new applyOn: aBrowser ]
		ifNone: [  ]
]

{ #category : #'as yet unclassified' }
AbstractBrowserMode class >> mode: aBrowser [
	^ self subclassResponsibility
]

{ #category : #'target resize' }
AbstractBrowserMode >> applyOn: aBrowser [
	^ self subclassResponsibility
]
