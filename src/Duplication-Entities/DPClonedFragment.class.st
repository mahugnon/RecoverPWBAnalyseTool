"
This represents duplicate code snippet. 
As a duplicate snippet appears in at least two places, hence code fragment has a collection of locations in members variable.

It has a hash that is computed from the contents of the duplicated snippet. 

"
Class {
	#name : #DPClonedFragment,
	#superclass : #MooseEntity,
	#instVars : [
		'members',
		'cloneName',
		'color'
	],
	#category : #'Duplication-Entities'
}

{ #category : #'instance creation' }
DPClonedFragment class >> initWith: aFragment [
	^ self new
		addMember: aFragment;
		yourself
]

{ #category : #accessing }
DPClonedFragment >> addMember: aFragmentLocation [
	self members add: aFragmentLocation.
	aFragmentLocation clonedFragment: self
]

{ #category : #testing }
DPClonedFragment >> allMembersArePresentIn: anotherFragment [
	^ self members size <= anotherFragment members size
		and: [ 
			self members
				allSatisfy: [ :aMember | 
					anotherFragment members
						anySatisfy: [ :anotherMember | anotherMember entity = aMember entity and: [ anotherMember locationFileName = aMember locationFileName ] ] ] ]
]

{ #category : #enumerating }
DPClonedFragment >> averageNumberOfLines [
	self members ifEmpty: [ ^ SYNUnavailableMetric ].
	^ (self members sum: #length) / self members size
]

{ #category : #accessing }
DPClonedFragment >> cloneName [
	^cloneName
]

{ #category : #accessing }
DPClonedFragment >> cloneName: aString [
	cloneName := aString.
]

{ #category : #accessing }
DPClonedFragment >> codeText [
	^ members anyOne  codeText
]

{ #category : #accessing }
DPClonedFragment >> color [
	^ color
]

{ #category : #accessing }
DPClonedFragment >> color: anObject [
	color := anObject
]

{ #category : #merge }
DPClonedFragment >> getMemberCorrespondingTo: aFragmentLocation [
	| possibleFragments |
	"We need to check the file anchor because an entity can have multiple fileAnchor."
	possibleFragments := self members select: [ :location | location entity = aFragmentLocation entity and: [ location fileAnchor = aFragmentLocation fileAnchor ] ].	
			
	"If there is only one result, it's the good one. If there is multiple result, there we can try to find the right result if a location contains a part of another location. Else we cannot find the right location and we return nil."
	
	^ possibleFragments size = 1
		ifTrue: [ possibleFragments anyOne ]
		ifFalse: [ 
			possibleFragments
				detect: [ :each | 
					(each startLine <= aFragmentLocation startLine and: [ each endLine >= aFragmentLocation startLine ])
						or: [ aFragmentLocation startLine <= each startLine and: [ aFragmentLocation endLine >= each startLine ] ] ]
				ifNone: [ nil ] ]
]

{ #category : #testing }
DPClonedFragment >> hasContiguousMemberWith: aLocation [
	^ self members anySatisfy: [ :anotherLocation | aLocation contiguousWith: anotherLocation ]
]

{ #category : #testing }
DPClonedFragment >> hasMembers [
	^ self members isNotEmpty
]

{ #category : #enumerating }
DPClonedFragment >> locationsOfCloneClass [
	^ self members collectAsSet: #entity
]

{ #category : #accessing }
DPClonedFragment >> members [
	<navigation: 'Members of this clone fragment'>
	^ members ifNil: [ members := OrderedCollection new ]
]

{ #category : #accessing }
DPClonedFragment >> members: anObject [
	members := anObject.
]

{ #category : #merge }
DPClonedFragment >> mergeWith: anotherFragment dupSys: aDupSys [
  "I try to merge with another fragment. If I fail I return false to signal the merge was not finished."
  (self mergeableWith: anotherFragment) ifFalse: [ ^true ].
  self members do: [:member |  (anotherFragment getMemberCorrespondingTo: member) ifNotNil: [:anotherMember |  member startLine: (member startLine min: anotherMember startLine).
              member endLine: (member endLine max: anotherMember endLine).
              anotherFragment remove: anotherMember ] ].
  ^anotherFragment hasMembers ifFalse: [ aDupSys fragments remove: anotherFragment ifAbsent: [  ].
        true ] ifTrue: [ false ]
]

{ #category : #testing }
DPClonedFragment >> mergeableWith: anotherFragment [
	anotherFragment = self ifTrue: [ ^ false ].
	
	^ (self members allSatisfy: [ :location | anotherFragment hasContiguousMemberWith: location ])
		and: [ anotherFragment members allSatisfy: [ :location | self hasContiguousMemberWith: location ] ]
]

{ #category : #printing }
DPClonedFragment >> mooseNameOn: aStream [
	aStream << self cloneName ifNil: [ #noname ]
]

{ #category : #accessing }
DPClonedFragment >> printOn: aStream [
	super printOn: aStream.
	aStream
		space;
		nextPut: $[;
		nextPutAll: self members size asString;
		nextPutAll: ' fragments]'
]

{ #category : #private }
DPClonedFragment >> properties [
	^ {('Number of files' -> self members size asString).
	('Number of cloned lines' -> self averageNumberOfLines asInteger asString)}
]

{ #category : #merge }
DPClonedFragment >> putLocationsIntoEntities [
	self members do: [ :aLocation | aLocation putIntoEntity ]
]

{ #category : #merge }
DPClonedFragment >> remove: aFragmentLocation [
	aFragmentLocation entity removeLocation: aFragmentLocation.
	aFragmentLocation entity: nil.
	self members remove: aFragmentLocation.
	
]

{ #category : #merge }
DPClonedFragment >> tryToExpandWith: anotherFragment [
	self members
		do: [ :aMember | 
			anotherFragment members
				select: [ :anotherMember | anotherMember entity = aMember entity ]
				thenDo: [ :anotherMember | 
					((anotherMember contiguousWith: aMember) or: [ aMember contiguousWith: anotherMember ])
						ifTrue: [
							aMember startLine: (aMember startLine min: anotherMember startLine).
							aMember endLine: (aMember endLine max: anotherMember endLine) ] ] ]
]
