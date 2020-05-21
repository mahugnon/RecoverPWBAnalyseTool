Class {
	#name : #PowerbuliderFragment,
	#superclass : #Object,
	#instVars : [
		'dupAloFragment',
		'color',
		'members'
	],
	#category : #'PowerBuilderAnalyzeTool-DuplicationBrowser-BackEndStrategy'
}

{ #category : #accessing }
PowerbuliderFragment >> color: anObject [
	color := anObject
]

{ #category : #accessing }
PowerbuliderFragment >> dupAloFragment: aFragment [
	dupAloFragment := aFragment
]

{ #category : #accessing }
PowerbuliderFragment >> members [
	members
		ifNil: [ members := dupAloFragment members
				collect: [ :each | 
					PowerbuliderLocation new
						dupAloDupLocation: each;
						clonedFragment: self ]
				as: OrderedCollection ].
	^ members
]
