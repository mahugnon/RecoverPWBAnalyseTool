Class {
	#name : #PWBLastChangesFilesFromSVN,
	#superclass : #PWBLastChangesFileDownloader,
	#category : #'PowerBuilderAnalyzeTool-PWBCriticsBrowser'
}

{ #category : #'as yet unclassified' }
PWBLastChangesFilesFromSVN class >> vcs [
	^ 'svn'
]

{ #category : #accessing }
PWBLastChangesFilesFromSVN >> downloadLastChanges [
	^ self lastChanges
		collect: [ :each | 
			self
				crTrace:
					(LibC
						resultOfCommand:
							'svn export ' , repoPathString , '/' , each trim , '  '
								, self protectChanges).
			self protectChanges
				, (each trim copyWithRegex: '.*src' matchesReplacedWith: '') ]
]

{ #category : #accessing }
PWBLastChangesFilesFromSVN >> lastChanges [
	| changes changesSeparator  |
	changes := LibC
		resultOfCommand: 'svn diff -c ' , self revisionHead , ' ' , repoPathString.
	changesSeparator := '==================================================================='.
	^ (((changesSeparator split: changes)
		collect:
			[ :each | each copyWithRegex: '.*Index|.*stream' matchesReplacedWith: '' ])
		reject:
			[ :each | (each endsWith: 'pbl' , String crlf) or: [ each = String crlf ] ])
		collect: [ :each | each copyReplaceAll: ':' with: '' ]
]

{ #category : #accessing }
PWBLastChangesFilesFromSVN >> revisionHead [
	| head result |
	result := LibC
		resultOfCommand: 'svn log --limit 1 ' , repoPathString.
	result := '|' split: result.
	head := result first copyWithRegex: '-.*r' matchesReplacedWith: ''.
	^ head
]
