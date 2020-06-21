Class {
	#name : #PWBMethodContext,
	#superclass : #AbstractPWBContextMenu,
	#category : #'PowerBuilderAnalyzeTool-ModelBrowser-Browser'
}

{ #category : #visiting }
PWBMethodContext class >> accept: anEntity [
	^ anEntity isKindOf: FamixPWBBehavioral
]

{ #category : #actions }
PWBMethodContext >> actions [
	^ {#variables . #browseDependencies}
]

{ #category : #menu }
PWBMethodContext >> browseDependencies [

]
