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
FamixPWBmajorObject >> isGenerallyUsed: obj [
	^ {'uo_datawindow' . 'uo_traitement' . 'uo_parametres' . 'uo_dw_detail'.
	'uo_liste_detail_en_partage'} includes: obj name
]

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
FamixPWBmajorObject >> numberOfIncomingInvocations [
	^ self content
		inject: 0
		into: [ :sum :each | sum + each numberOfIncomingInvocations ]
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
