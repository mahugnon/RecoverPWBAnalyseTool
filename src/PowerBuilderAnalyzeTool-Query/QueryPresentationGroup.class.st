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
			| groups |
			(value includes: key)
				ifFalse: [ value add: key ].
			groups := merge select: [ :aGroup | (aGroup & value) isNotEmpty ].
			groups
				ifEmpty: [ merge add: value ]
				ifNotEmpty: [ | eachAndValue |
					eachAndValue := (value , groups flatten) asSet
						select: [ :majorObject | majorObject isTaggedWith: presentation ].
					merge removeAll: groups.
					merge add: eachAndValue ] ].
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
			(key isTaggedWith: presentation)
				ifTrue: [ | resultValue |
					resultValue := (value
						flatCollect: [ :inv | inv candidates collectAsSet: #parentType ])
						select: [ :obj | obj isNotNil and: [ obj isTaggedWith: presentation ] ].
					resultValue ifNotEmpty: [ result at: key put: resultValue ] ] ].
	^ result
]

{ #category : #running }
QueryPresentationGroup >> runOn: aMooseModel [
	self halt.
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
