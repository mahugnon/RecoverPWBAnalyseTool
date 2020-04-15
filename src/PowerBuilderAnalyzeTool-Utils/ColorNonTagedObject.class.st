Class {
	#name : #ColorNonTagedObject,
	#superclass : #ColorObject,
	#category : #'PowerBuilderAnalyzeTool-Utils-RoassalElementColorStrategy'
}

{ #category : #private }
ColorNonTagedObject class >> accept: anEntity [
	^ ((anEntity allTags collect: #name) & self futureActionTags) isEmpty
]

{ #category : #accessing }
ColorNonTagedObject >> color [
	^ Color gray
]
