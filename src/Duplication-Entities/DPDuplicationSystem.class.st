"
I am the result of the application of duplication detection to a source code. I know all the code fragments that are detected and their locations. I can be parameterized for min. number of lines of code to report. I also know how to merge adjacent duplicate fragment to report one big contiguous duplicate fragment instead of several several small ones.

I can serialize myself on the disk in XML format.
"
Class {
	#name : #DPDuplicationSystem,
	#superclass : #Object,
	#instVars : [
		'fragments',
		'parameters'
	],
	#category : #'Duplication-Entities'
}

{ #category : #'from-dude' }
DPDuplicationSystem class >> cloneLocationFromMultiplications: dudeMultiplications forEntity: aSynEntity [
		^ self new fragments: (dudeMultiplications
				collect: [ :mult | 
					| ref locations |
					locations := mult duplications
						collect: [ :dudeDup | 
							| dd |
							dd := dudeDup duplicateCode.
							DPFragmentLocation from: dd beginLine to: dd endLine for: aSynEntity ].
					ref := mult duplications first referenceCode.
					locations add: (DPFragmentLocation from: ref beginLine to: ref endLine for: aSynEntity).
					DPClonedFragment new members: locations])
]

{ #category : #'from-dude' }
DPDuplicationSystem class >> newFrom: dudeMultiplications with: aModel [
	^ self new
		fragments:
			(dudeMultiplications
				collect: [ :mult | 
					| ref locations |
					locations := mult duplications
						collect: [ :dudeDup | 
							| dd |
							dd := dudeDup duplicateCode.
							DPFragmentLocation from: dd beginLine to: dd endLine for: (aModel entityNamed: dd entity mooseName) ].
					ref := mult duplications first referenceCode.
					locations add: (DPFragmentLocation from: ref beginLine to: ref endLine for: (aModel entityNamed: ref entity mooseName)).
					DPClonedFragment new members: locations ])
]

{ #category : #improving }
DPDuplicationSystem >> expandLesserFragments [
	self
		traceCr: 'Expand ' , self fragments size asString , ' fragments.'.
	self fragments
		do: [ :aFragment | 
			self fragments
				do: [ :anotherFragment | 
					aFragment = anotherFragment
						ifFalse: [ (aFragment allMembersArePresentIn: anotherFragment)
								ifTrue:
									[ "here we have fragments that are a subgroup of another fragment in term of files so we can expand aFragment" aFragment tryToExpandWith: anotherFragment ] ] ] ]
]

{ #category : #accessing }
DPDuplicationSystem >> fragments [
	^ fragments ifNil: [ fragments := OrderedCollection new ]
]

{ #category : #accessing }
DPDuplicationSystem >> fragments: aCollection [
	fragments := OrderedCollection newFrom: aCollection.
	self initFragmentNames.
]

{ #category : #accessing }
DPDuplicationSystem >> fragmentsSortedBySize [
	^ self fragments sorted: [:a :b | a averageNumberOfLines > b averageNumberOfLines ]
]

{ #category : #'fragment-names' }
DPDuplicationSystem >> initFragmentNames [
	fragments doWithIndex: [ :each :index | each cloneName: 'Code Fragment ' , index asString ]
]

{ #category : #postProcess }
DPDuplicationSystem >> mergeExplicitFragmentAReturnIfTheMergeIsFinished [
	"In this method I'll try to merge a maximum of fragments but it will not be possible all the time because some fragments can be part of the same duplication but not be contigious yet. I should return true if the merge is finished and false if I was not able to merge all the possible fragments."

	| programsWithDuplication isAbleToMergeAllFragments |
	isAbleToMergeAllFragments := true.
	self
		traceCr:
			'Merge ' , self fragments size asString , ' fragments of duplication.'.
	programsWithDuplication := self fragments
		flatCollectAsSet: #locationsOfCloneClass.
	programsWithDuplication
		do: [ :aProgram | 
			(aProgram mergePossibleDuplications: self)
				ifFalse: [ isAbleToMergeAllFragments := false ] ]
		displayingProgress: [ :aProgram | 'Merging: ' , aProgram name ].
	^ isAbleToMergeAllFragments
]

{ #category : #postProcess }
DPDuplicationSystem >> mergeMultipleFragments [
	"In this method I merge some duplication fragments because if I have a fragment in an entity from line 10 to 15 and one from line 13 to 17, at the end it can be a fragment from line 10 to 17. It is not sure that we can do it in one iteration so I'll repeat the operation until I am able to fully merge all the fragments."

	[ self mergeExplicitFragmentAReturnIfTheMergeIsFinished ] whileFalse
]

{ #category : #accessing }
DPDuplicationSystem >> parameters [
	^ parameters
]

{ #category : #accessing }
DPDuplicationSystem >> parameters: anObject [
	parameters := anObject
]

{ #category : #initialization }
DPDuplicationSystem >> setColors [
	| colors |
	colors := Color wheel: fragments size.
	1 to: colors size do: [ :iterator | (fragments at: iterator) color: (colors at: iterator) ]
]
