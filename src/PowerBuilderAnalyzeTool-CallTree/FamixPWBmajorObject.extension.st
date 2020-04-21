Extension { #name : #FamixPWBmajorObject }

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
FamixPWBmajorObject >> clean: aCollection [
	^ aCollection reject: [ :each | self isGenerallyUsed:  each  ]
]

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
FamixPWBmajorObject >> content [

	^ content
]

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
FamixPWBmajorObject >> numberOfMethods [
	^ self content size
]

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
FamixPWBmajorObject >> roassalPresenter [
	^ CIMUserObjectReferencesPresenter
]

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
FamixPWBmajorObject >> setContent [
	content := ((self methods asSet
		reject: [ :method | method isNoisyMethod ])
		flatCollect: #withAllOutgoingInvocationCandidates)
		asOrderedCollection
		sort: [ :a :b | a numberOfMethods  > b numberOfMethods ]
]

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
FamixPWBmajorObject >> toSkipForNow: anObject [
	self flag: 'To be considered later'.
	^ {FamixPWBCustomType} includes: anObject class
]
