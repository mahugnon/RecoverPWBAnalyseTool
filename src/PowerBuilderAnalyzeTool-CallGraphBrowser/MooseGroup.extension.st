Extension { #name : #MooseGroup }

{ #category : #'*PowerBuilderAnalyzeTool-CallGraphBrowser' }
MooseGroup >> cyclomaticComplexity [
	^ self content
		inject: 0
		into: [ :sum :each | sum + each cyclomaticComplexity ]
]

{ #category : #'*PowerBuilderAnalyzeTool-CallGraphBrowser' }
MooseGroup >> numberOfIncomingInvocations [
	^ self content
		inject: 0
		into: [ :sum :each | sum + each numberOfIncomingInvocations ]
]

{ #category : #'*PowerBuilderAnalyzeTool-CallGraphBrowser' }
MooseGroup >> numberOfLinesOfCode [
	^ self content
		inject: 0
		into: [ :sum :each | sum + each numberOfLinesOfCode ]
]

{ #category : #'*PowerBuilderAnalyzeTool-CallGraphBrowser' }
MooseGroup >> outgoingInvocations [
	^ self content collect: #outgoingInvocations
]

{ #category : #'*PowerBuilderAnalyzeTool-CallGraphBrowser' }
MooseGroup >> roassalPresenter [
	self isEmpty
		ifTrue: [ ^ self ].
	^ self first roassalPresenter
]
