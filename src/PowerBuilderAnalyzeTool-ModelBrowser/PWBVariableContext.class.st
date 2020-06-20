Class {
	#name : #PWBVariableContext,
	#superclass : #AbstractPWBContextMenu,
	#category : #'PowerBuilderAnalyzeTool-ModelBrowser-Browser'
}

{ #category : #visiting }
PWBVariableContext class >> accept: anEntity [
	^ (anEntity isKindOf: FamixPWBVariable)
		or: [ anEntity isKindOf: FamixPWBAttribute ]
]
