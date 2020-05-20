Class {
	#name : #PowerbuliderLocation,
	#superclass : #Object,
	#instVars : [
		'dupAloDupLocation',
		'clonedFragment'
	],
	#category : #'PowerBuilderAnalyzeTool-DuplicationGUI'
}

{ #category : #accessing }
PowerbuliderLocation >> clonedFragment [
	^ clonedFragment
]

{ #category : #accessing }
PowerbuliderLocation >> clonedFragment: aPowerbuliderDuplicationSystem [
	clonedFragment := aPowerbuliderDuplicationSystem
]

{ #category : #accessing }
PowerbuliderLocation >> dupAloDupLocation: anAloDupLocation [
	dupAloDupLocation := anAloDupLocation
]

{ #category : #'accessing ' }
PowerbuliderLocation >> entity [
	^ dupAloDupLocation entity
]

{ #category : #'class membership' }
PowerbuliderLocation >> isMemberOf: aClonedFragment [
	^ self clonedFragment = aClonedFragment
]
