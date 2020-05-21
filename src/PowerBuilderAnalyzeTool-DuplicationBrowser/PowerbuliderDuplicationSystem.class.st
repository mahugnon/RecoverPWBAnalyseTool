Class {
	#name : #PowerbuliderDuplicationSystem,
	#superclass : #Object,
	#instVars : [
		'dupAlgoSystem',
		'fragments'
	],
	#category : #'PowerBuilderAnalyzeTool-DuplicationBrowser-BackEndStrategy'
}

{ #category : #'instance creation' }
PowerbuliderDuplicationSystem class >> withAll: aCollection [
	^ self new addAll: aCollection
]

{ #category : #adding }
PowerbuliderDuplicationSystem >> addAll: aCollection [
	fragments := aCollection
		collect: [ :each | 
			PowerbuliderFragment new
				dupAloFragment: each;
				yourself ]
		as: OrderedCollection
]

{ #category : #accessing }
PowerbuliderDuplicationSystem >> fragments [
	^ fragments
]

{ #category : #initialization }
PowerbuliderDuplicationSystem >> setColors [
	| colors |
	colors := Color wheel: fragments size.
	1 to: colors size do: [ :iterator | (fragments at: iterator) color: (colors at: iterator) ]
]
