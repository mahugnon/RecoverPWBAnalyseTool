Class {
	#name : #PWBCriticsRunner,
	#superclass : #Object,
	#instVars : [
		'criticResults',
		'files'
	],
	#category : #'PowerBuilderAnalyzeTool-PWBCriticsBrowser'
}

{ #category : #'as yet unclassified' }
PWBCriticsRunner class >> downloadLastChangesFromRepo: aRepoPathString [
	| head result changes  changesSeparator filesRelativePath |

	result := LibC resultOfCommand: 'svn log --limit 1 ' , aRepoPathString.
	result := '|' split: result.
	head := result first copyWithRegex: '-.*r' matchesReplacedWith: ''.
	changes := LibC resultOfCommand: 'svn diff -c ' , head , ' ' ,  aRepoPathString.
	changesSeparator := '==================================================================='.
	filesRelativePath := (((changesSeparator split: changes)
		collect:
			[ :each | each copyWithRegex: '.*Index|.*stream' matchesReplacedWith: '' ])
		reject: [ :each | (each endsWith: 'pbl' , String crlf) or: [ each = String crlf ] ])
		collect: [ :each | each copyReplaceAll: ':' with: '' ]
]

{ #category : #running }
PWBCriticsRunner class >> runOn: aCollection [
	^ self new
		files: aCollection;
		runAll
]

{ #category : #accessing }
PWBCriticsRunner >> files: aCollection [
	files := aCollection
	
]

{ #category : #initialization }
PWBCriticsRunner >> initialize [
	super initialize.
	criticResults := Dictionary new
]

{ #category : #actions }
PWBCriticsRunner >> runAll [
	files
		do:
			[ :aFile | criticResults at: aFile name put: (PWBCriticsResult new file: aFile) ]
]
