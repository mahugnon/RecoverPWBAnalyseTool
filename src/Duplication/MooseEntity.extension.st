Extension { #name : #MooseEntity }

{ #category : #'*Duplication' }
MooseEntity >> addCloneLocation: anObject [ 
	self cloneLocations add: anObject
]

{ #category : #'*Duplication' }
MooseEntity >> clearDuplicationCache [
	self propertyNamed: #cloneLocations put: OrderedCollection new
]

{ #category : #'*Duplication' }
MooseEntity >> cloneLocationLineIntervals [
  ^self cloneLocations collect: [:each |  each startLine to: each endLine ]
]

{ #category : #'*Duplication' }
MooseEntity >> cloneLocations [
  < MSEProperty: #cloneLocations type: #DPFragmentLocation>
  < MSEComment: 'A collection of fragments of cloned code found in this program'>
  < derived>
  ^self propertyNamed: #cloneLocations ifAbsentPut: [ OrderedCollection new ]
]

{ #category : #'*Duplication' }
MooseEntity >> codeDuplicationIntervals [
  | text |
  text := self completeText.
  ^self cloneLocations collect: [:aCloneLocation |  (text intervalOfLine: aCloneLocation startLine) first to: (text intervalOfLine: aCloneLocation endLine) last ]
]

{ #category : #'*Duplication' }
MooseEntity >> containsClone [
  ^self cloneLocations isNotEmpty
]

{ #category : #'*Duplication' }
MooseEntity >> duplicatedSourceText [
  ^self cloneLocations collect: [:aCloneLocation |  (self sourceText intervalOfLine: aCloneLocation startLine) first to: (self sourceText intervalOfLine: aCloneLocation endLine) last ]
]

{ #category : #'*Duplication' }
MooseEntity >> duplicationRate [
  < MSEProperty: #duplicationRate type: #Number>
  < MSEComment: 'Duplication Rate.'>
  < derived>
  ^self cloneLocations ifEmpty: [ 0 ] ifNotEmpty: [:cloneLocations |  | accumulator usefulCloneLocations |
        accumulator := 0.
        
        "We remove the localisations already included in other localisations because this add noise."usefulCloneLocations := cloneLocations inject: OrderedCollection new into: [:res :cl |  res detect: [:loc |  loc includesLocation: cl ] ifNone: [ res add: cl ].
              res ].
        
        "We sort the fragments by startline to get the contiguous next to each other."usefulCloneLocations sort: [:a :b |  a startLine < b startLine ].
        usefulCloneLocations allButLast do: [:aLocation |  (aLocation contiguousWith: (usefulCloneLocations after: aLocation)) ifTrue: [ accumulator := accumulator + (usefulCloneLocations after: aLocation) startLine - aLocation startLine ] ifFalse: [ accumulator := accumulator + aLocation length ] ].
        accumulator := accumulator + usefulCloneLocations last length.
        accumulator / self numberOfLinesOfCode ]
]

{ #category : #'*Duplication' }
MooseEntity >> mergePossibleDuplications: aDupSystem [
  "I try to merge the duplication and if I fail I return false."
  | mergeIndex innerIndex oneDup anotherDup wasAbleToMergeAll |
  wasAbleToMergeAll := true.
  mergeIndex := 1.
  [ mergeIndex <= self cloneLocations size ] whileTrue: [ innerIndex := mergeIndex + 1.
        [ innerIndex <= self cloneLocations size ] whileTrue: [ oneDup := (self cloneLocations at: mergeIndex) clonedFragment.
              anotherDup := (self cloneLocations at: innerIndex) clonedFragment.
              (oneDup mergeWith: anotherDup dupSys: aDupSystem) ifFalse: [ wasAbleToMergeAll := false ].
              innerIndex := innerIndex + 1 ].
        mergeIndex := mergeIndex + 1 ].
  ^wasAbleToMergeAll
]

{ #category : #'*Duplication' }
MooseEntity >> removeLocation: aFragmentLocation [
	self containsClone ifTrue: [ self cloneLocations remove: aFragmentLocation ]
]
