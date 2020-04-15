Class {
	#name : #ColorTagedObject,
	#superclass : #ColorObject,
	#category : #'PowerBuilderAnalyzeTool-Utils-RoassalElementColorStrategy'
}

{ #category : #private }
ColorTagedObject class >> accept: anEntity [
	^ ((anEntity allTags collect: #name) & self futureActionTags)
		isNotEmpty
]

{ #category : #accessing }
ColorTagedObject >> color [
	^ (entity
		tagNamed:
			((entity allTags collect: #name) & self class futureActionTags) anyOne)
		color
]
