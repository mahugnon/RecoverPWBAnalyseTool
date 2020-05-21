Extension { #name : #FamixPWBmajorObject }

{ #category : #'*PowerBuilderAnalyzeTool-CallGraphBrowser' }
FamixPWBmajorObject >> clean: aCollection [
	^ aCollection reject: [ :each | self isGenerallyUsed:  each  ]
]

{ #category : #'*PowerBuilderAnalyzeTool-CallGraphBrowser' }
FamixPWBmajorObject >> content [

	^ content
]

{ #category : #'*PowerBuilderAnalyzeTool-CallGraphBrowser' }
FamixPWBmajorObject >> numberOfMethods [
	^ self content size
]

{ #category : #'*PowerBuilderAnalyzeTool-CallGraphBrowser' }
FamixPWBmajorObject >> roassalPresenter [
	^ CIMUserObjectReferencesPresenter
]

{ #category : #'*PowerBuilderAnalyzeTool-CallGraphBrowser' }
FamixPWBmajorObject >> setContent [
	content := ((self methods asSet
		reject: [ :method | method isNoisyMethod ])
		flatCollect: #withAllOutgoingInvocationCandidates)
		asOrderedCollection
		sort: [ :a :b | a numberOfMethods  > b numberOfMethods ]
]

{ #category : #'*PowerBuilderAnalyzeTool-CallGraphBrowser' }
FamixPWBmajorObject >> toSkipForNow: anObject [
	self flag: 'To be considered later'.
	^ {FamixPWBCustomType} includes: anObject class
]
