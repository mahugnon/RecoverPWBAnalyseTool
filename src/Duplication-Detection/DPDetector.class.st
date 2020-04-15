"
The duplication algorithm is implemented in the class DPDetector that first cleans code of any white spaces and comments. For the cleaned lines, a hash is computed because two exactly similar strings will have the same hash. A dictionary is created with hashes as keys and clone fragments as values. At the end, the algorithm looks for all the clone fragments and reports them.  

At the end, adjacent clone fragments are merged to report one fragment instead of several adjacent ones. The user can provide parameters for a code fragment: minimum lines of code and number of locations.
"
Class {
	#name : #DPDetector,
	#superclass : #Object,
	#instVars : [
		'parameters',
		'bucket'
	],
	#category : #'Duplication-Detection'
}

{ #category : #'entry-point' }
DPDetector class >> runOn: aMooseGroup parametrizedWith: aDPParameters [
	^ self new
		parameters: aDPParameters;
		runOn: aMooseGroup
]

{ #category : #private }
DPDetector >> addLocation: fragmentLocation withText: aCollectionOfLines concatenated: concatenatedLines [
	bucket
		at: (self getHashFor: aCollectionOfLines concatenated: concatenatedLines)
		ifPresent: [ :clone | clone addMember: fragmentLocation ]
		ifAbsentPut: [ DPClonedFragment initWith: fragmentLocation ]
]

{ #category : #private }
DPDetector >> addText: aCollectionOfLines firstLineIndex: firstLineIndex lastLineIndex: lastLineIndex fileAnchor: fileAnchor entity: anEntity [
	| concatenatedLines |
	concatenatedLines := self getConcanetedLinesFrom: aCollectionOfLines.
	concatenatedLines size > parameters minNumberOfCharacters
		ifFalse: [ ^ self ].
		"self halt."
	self
		addLocation:
			(DPFragmentLocation new
				startLine: firstLineIndex;
				endLine: lastLineIndex;
				fileAnchor: fileAnchor;
				entity: anEntity;
				yourself)
		withText: aCollectionOfLines
		concatenated: concatenatedLines
]

{ #category : #accessing }
DPDetector >> bucket [
	^ bucket
]

{ #category : #'compute-hashes' }
DPDetector >> entitiesForDetectionFrom: aMooseGroup [
	"for duplication, we consider only those entities whose number of lines of code is greater or equal to the min number of lines of code for duplication detection"

	^ aMooseGroup select: [ :entity | entity numberOfLinesOfCode >= self parameters minNumberOfLines ]
]

{ #category : #accessing }
DPDetector >> getCleanLinesOf: aCollectionOfLines [
	| lines |
	"This could be more elegant but be careful, I need to be fast and doing a collect with index then a reject is longer."
	lines := OrderedCollection new.
	aCollectionOfLines
		doWithIndex: [ :aLine :index | 
			| cleanedLine |
			(aLine isEmpty
				or: [ (cleanedLine := parameters cleaner clean: aLine) isEmpty or: [ parameters cleaner isComment: cleanedLine ] ])
				ifFalse: [ lines add: index -> cleanedLine ] ].
	^ lines
]

{ #category : #private }
DPDetector >> getClonedFragments [
	| fragments |
	fragments := OrderedCollection new.
	bucket values
		select: [ :aFragment | aFragment members size >= parameters frequency ]
		thenDo: [ :aFragment | 
			fragments add: aFragment.
			aFragment putLocationsIntoEntities ].
	^ fragments
]

{ #category : #private }
DPDetector >> getConcanetedLinesFrom: aCollectionOfLines [
	"The use of #to:do: is done for performance reasons"
	
	^ String streamContents: [ :s | 1 to: aCollectionOfLines size do: [ :ind | s << (aCollectionOfLines at: ind) ] ]
]

{ #category : #private }
DPDetector >> getHashFor: aCollectionOfLines concatenated: concatenateLines [
	^ concatenateLines hash * 10000000000000 + (String streamContents: [ :s | 1 to: aCollectionOfLines size do: [ :ind | s << (aCollectionOfLines at: ind) first ] ]) hash
]

{ #category : #initialization }
DPDetector >> initialize [ 
	bucket := Dictionary new.
]

{ #category : #accessing }
DPDetector >> parameters [
	^ parameters
]

{ #category : #accessing }
DPDetector >> parameters: anObject [
	parameters := anObject
]

{ #category : #accessing }
DPDetector >> registerFragmentsFor: aProgram [
	"for duplication, we consider only those entities whose number of lines of code is greater or equal to the min number of lines of code for duplication detection"

	aProgram numberOfLinesOfCode >= self parameters minNumberOfLines
		ifFalse: [ ^ self ].
	parameters cleaner reset.	"line added for Cobol"
	aProgram clearDuplicationCache.
	self
		registerFragmentsFor: aProgram
		sourceAnchor: aProgram sourceAnchor
]

{ #category : #accessing }
DPDetector >> registerFragmentsFor: aProgram sourceAnchor: sourceAnchor [
	| lines cleanedSourceAnchor |
	cleanedSourceAnchor := PWBPreprocessor parse: sourceAnchor sourceText.
	lines := self getCleanLinesOf: cleanedSourceAnchor lines.
	parameters minNumberOfLines > lines size
		ifTrue: [ ^ self ].
	(lines allButLast: parameters minNumberOfLines - 1)
		withIndexDo: [ :line :index | 
			self
				addText:
					((lines copyFrom: index to: index + parameters minNumberOfLines - 1)
						collect: #value)
				firstLineIndex: line key
				lastLineIndex: (lines at: index + parameters minNumberOfLines - 1) key
				fileAnchor: sourceAnchor
				entity: aProgram ]
]

{ #category : #'compute-hashes' }
DPDetector >> runOn: aCollection [
	| dup |
	aCollection
		do: [ :aProgram | self registerFragmentsFor: aProgram ]
		displayingProgress: 'Computing duplication' translated.
	dup := DPDuplicationSystem new
		fragments: self getClonedFragments;
		parameters: self parameters;
		mergeMultipleFragments;
		expandLesserFragments;
		initFragmentNames;
		"We reinit the names because some numbers might have been merge and there is an index in the fragment name."
			yourself.
	^ dup
]

{ #category : #'compute-hashes' }
DPDetector >> selectEntitiesWithEnoughInformationFrom: aCollection [
	"I reject the entities that does not have a source anchor or whose source anchor does not know the start or the end position of the source in a file because in that case we will read everything and display wrong informations."

	| res size |
	size := aCollection size.
	res := aCollection select: #hasSourceAnchor.
	((size - (size := res size)) asString , ' entities without source anchors were rejected.') synCrLog.
	res := res select: [ :entity | entity sourceAnchor knowsStart ].
	((size - (size := res size)) asString , ' entities whose source anchor does not knows the start position in its source were rejected.') synCrLog.
	res := res select: [ :entity | entity sourceAnchor knowsEnd ].
	((size - (size := res size)) asString , ' entities whose source anchor does not knows the end position in its source were rejected.') synCrLog.
	(size asString , ' entities with enough informations to run duplication on.') synCrLog.
	^ res
]
