Extension { #name : #MooseGroup }

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
MooseGroup >> cyclomaticComplexity [
	^ self content
		inject: 0
		into: [ :sum :each | sum + each cyclomaticComplexity ]
]

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
MooseGroup >> numberOfIncomingInvocations [
	^ self content
		inject: 0
		into: [ :sum :each | sum + each numberOfIncomingInvocations ]
]

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
MooseGroup >> numberOfLinesOfCode [
	^ self content
		inject: 0
		into: [ :sum :each | sum + each numberOfLinesOfCode ]
]

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
MooseGroup >> outgoingInvocations [
	^ self content collect: #outgoingInvocations
]

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
MooseGroup >> roassalPresenter [
	self isEmpty
		ifTrue: [ ^ self ].
	^ self first roassalPresenter
]
