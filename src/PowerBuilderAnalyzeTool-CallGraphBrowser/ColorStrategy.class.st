Class {
	#name : #ColorStrategy,
	#superclass : #Object,
	#instVars : [
		'entity'
	],
	#category : #'PowerBuilderAnalyzeTool-CallGraphBrowser-EntityColorStrategy'
}

{ #category : #private }
ColorStrategy class >> accept: aMooseAdapter [
  ^self subclassResponsibility
]

{ #category : #private }
ColorStrategy class >> colorFor: anEntity [
	^ (self subclasses detect: [ :class | class accept: anEntity ]) new
		entity: anEntity;
		color
]

{ #category : #accessing }
ColorStrategy >> color [
  ^self subclassResponsibility
]

{ #category : #accessing }
ColorStrategy >> entity [
	^ entity
]

{ #category : #accessing }
ColorStrategy >> entity: anObject [
	entity := anObject
]
