Class {
	#name : #PWBLastChangesFileDownloader,
	#superclass : #Object,
	#instVars : [
		'repoPathString'
	],
	#category : #'PowerBuilderAnalyzeTool-PWBCriticsBrowser'
}

{ #category : #accessing }
PWBLastChangesFileDownloader class >> lastChanges: aRepoPathString [
	^ self new
		repoPathString: aRepoPathString;
		downloadLastChanges
]

{ #category : #accessing }
PWBLastChangesFileDownloader class >> lastChanges: aRepoPathString vcs: aVCS [
	^ (self subclasses detect: [ :cls | cls vcs = aVCS ])
		lastChanges: aRepoPathString
]

{ #category : #accessing }
PWBLastChangesFileDownloader >> locationOfProjectRepo [
	"finds the location of the project (e.g., to find R files that are not part of Pharo)"

	| icebergRepository |
	icebergRepository := IceRepository registry
		detect: [ :repository | 
			repository workingCopy packages
				anySatisfy: [ :package | package name beginsWith: 'PowerBuilderAnalyzeTool' ] ]
		ifNone:
			[ self error: 'No repository in Iceberg containing the needed files.' ].
	icebergRepository location exists
		ifFalse: [ self
				error:
					'The repository of the project does not have a pointer to a local clone to find the files' ].
	^ icebergRepository location
]

{ #category : #accessing }
PWBLastChangesFileDownloader >> locationOfProjectRepo: aProject [
	"finds the location of the project (e.g., to find R files that are not part of Pharo)"

	| icebergRepository |
	icebergRepository := IceRepository registry
		detect: [ :repository | 
			repository workingCopy packages
				anySatisfy: [ :package | package name = aProject ] ]
		ifNone:
			[ self error: 'No repository in Iceberg containing the needed files.' ].
	icebergRepository location exists
		ifFalse: [ self
				error:
					'The repository of the project does not have a pointer to a local clone to find the files' ].
	^ icebergRepository location
]

{ #category : #'as yet unclassified' }
PWBLastChangesFileDownloader >> protectChanges [
	(self locationOfProjectRepo / 'protectChanges') ensureCreateDirectory.
	^ self locationOfProjectRepo pathString , '/protectChanges'
]

{ #category : #accessing }
PWBLastChangesFileDownloader >> repoPathString [
	^ repoPathString
]

{ #category : #accessing }
PWBLastChangesFileDownloader >> repoPathString: anObject [
	repoPathString := anObject
]
