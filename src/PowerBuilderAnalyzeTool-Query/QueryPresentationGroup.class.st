Class {
	#name : #QueryPresentationGroup,
	#superclass : #AbstractPWBQuery,
	#instVars : [
		'presentation'
	],
	#category : #'PowerBuilderAnalyzeTool-Query'
}

{ #category : #'as yet unclassified' }
QueryPresentationGroup >> allInvocations: aCollection [
	^ ((aCollection  flatCollect: [ :each| each methods collect: [ :m| { m incomingInvocations . m outgoingInvocations  } flatten  asSet ]    ] as: Set) flatten ) groupedBy: [:inv| inv  sender parentType]
]

{ #category : #'as yet unclassified' }
QueryPresentationGroup >> mergePresentationEntitiesPartialGroup: aCollection [
	| merge |
	merge := OrderedCollection with: aCollection anyOne.
	aCollection
		keysAndValuesDo: [ :key :value | 
			(value includes: key)
				ifFalse: [ value add: key ].
			merge
				do: [ :each | 
					each & value
						ifEmpty: [ merge add: value ]
						ifNotEmpty: [ | eachAndValue |
							eachAndValue := (value , each) asSet
								select: [ :majorObject | majorObject isTaggedWith: presentation ].
							merge remove: each.
							merge add: eachAndValue ] ] ].
	^ merge
]

{ #category : #'as yet unclassified' }
QueryPresentationGroup >> presentationEntities: aModel [
	^ presentation taggedEntities
		reject: [ :e | e isKindOf: FamixPWBDataWindow ]
]

{ #category : #'as yet unclassified' }
QueryPresentationGroup >> presentationEntitiesPartialGroup: aCollection [
	| result |
	result := OrderedDictionary new.
	aCollection
		keysAndValuesDo: [ :key :value | 
			result
				at: key
				put:
					(value
						flatCollect: [ :inv | inv candidates collectAsSet: #parentType ]) ].
	^ result
]

{ #category : #running }
QueryPresentationGroup >> runOn: aMooseModel [
	self tag: aMooseModel.
	^ self
		mergePresentationEntitiesPartialGroup:
			(self
				presentationEntitiesPartialGroup: (self allInvocations: (self presentationEntities: aMooseModel)))
]

{ #category : #'as yet unclassified' }
QueryPresentationGroup >> tag: aModel [
	presentation := aModel findTagNamed: 'Presentation'
]
