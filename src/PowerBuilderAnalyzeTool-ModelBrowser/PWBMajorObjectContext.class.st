Class {
	#name : #PWBMajorObjectContext,
	#superclass : #AbstractPWBContextMenu,
	#category : #'PowerBuilderAnalyzeTool-ModelBrowser-Browser'
}

{ #category : #visiting }
PWBMajorObjectContext class >> accept: anEntity [
	^ anEntity isKindOf: FamixPWBmajorObject
]

{ #category : #actions }
PWBMajorObjectContext >> actions [
	^ {#methods . #variables . #browseDependencies}
]

{ #category : #api }
PWBMajorObjectContext >> methods [
	self shouldBeImplemented.
]
