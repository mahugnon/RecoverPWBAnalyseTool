Class {
	#name : #ColorObject,
	#superclass : #ColorStrategy,
	#category : #'PowerBuilderAnalyzeTool-CallGraphBrowser-EntityColorStrategy'
}

{ #category : #private }
ColorObject class >> colorFor: anEntity [
	^ self new colorFor: anEntity
]

{ #category : #private }
ColorObject >> colorFor: anEntity [
	^ anEntity tags
		detect: [ :aTag | 
			aTag
				hasCategory: (anEntity mooseModel tagCategoryNamed: self tagCategory) ]
		ifFound: [ :foundedTag | foundedTag color ]
		ifNone: [ self defaultColor ]
]

{ #category : #private }
ColorObject >> defaultColor [
	^ Color gray
]

{ #category : #'as yet unclassified' }
ColorObject >> tagCategory [
	^ #Actions
]
