"
The class represents one of the several locations where duplicated code exists. A location knows its code fragment.

entity can be an entity that implements TBehaviouralEntity trait to limit to the entities that have significant amount of source code such as methods, functions or modules.

StartLine and endLines are the lines in the file where duplicate snippet start and end.

An entity also knows about its locations >> see clone locations.
"
Class {
	#name : #DPFragmentLocation,
	#superclass : #MooseEntity,
	#instVars : [
		'startLine',
		'endLine',
		'entity',
		'clonedFragment',
		'fileAnchor',
		'codeText'
	],
	#category : #'Duplication-Entities'
}

{ #category : #'instance creation' }
DPFragmentLocation class >> from: start to: end for: anEntity [
	"Adds clone location in entity setted in this location"
	| result |

	result := self new
		startLine: start;
		endLine: end;
		entity: anEntity;
		yourself.
	anEntity addCloneLocation: result.
	^ result.
]

{ #category : #'instance creation' }
DPFragmentLocation class >> from: start to: end in: fileAnchor for: anEntity [
	"Adds clone location in entity setted in this location"
	| result |

	result := self new
		startLine: start;
		endLine: end;
		fileAnchor: fileAnchor;
		entity: anEntity;
		yourself.
	anEntity addCloneLocation: result.
	^ result.
]

{ #category : #accessing }
DPFragmentLocation >> clonedFragment [ 
	^ clonedFragment
]

{ #category : #accessing }
DPFragmentLocation >> clonedFragment: anObject [ 
	clonedFragment := anObject.
]

{ #category : #accessing }
DPFragmentLocation >> codeText [
  | text |
  codeText ifNil: [ text := self entitySourceCode.
        codeText := text copyFrom: (text intervalOfLine: self startLine) first to: (text intervalOfLine: self endLine) last ].
  ^codeText
]

{ #category : #accessing }
DPFragmentLocation >> color [
	^ clonedFragment color
]

{ #category : #merge }
DPFragmentLocation >> contiguousWith: anotherLocation [
	^ self entity = anotherLocation entity
		and: [ 
			self locationFileName = anotherLocation locationFileName
				and: [ self startLine <= (anotherLocation endLine + 1) and: [ self endLine + 1 >= anotherLocation startLine ] ] ]
]

{ #category : #accessing }
DPFragmentLocation >> endLine [
	<navigation: 'Ending line of code duplication'>
	^ endLine
]

{ #category : #accessing }
DPFragmentLocation >> endLine: anObject [
	endLine := anObject
]

{ #category : #'as yet unclassified' }
DPFragmentLocation >> endLineInOriginalFile [
	^ self lineNumberCorrespondingToLine: self endLine
]

{ #category : #accessing }
DPFragmentLocation >> entity [
	<navigation: 'The entity of this code fragment'>
	^ entity
]

{ #category : #accessing }
DPFragmentLocation >> entity: anEntity [
	entity := anEntity.
]

{ #category : #accessing }
DPFragmentLocation >> entitySourceCode [
	^ self fileAnchor sourceText
]

{ #category : #accessing }
DPFragmentLocation >> fileAnchor [
	<navigation: 'The file of the entity that contains the duplicated code fragment'>
	^ fileAnchor ifNil: [ FAMIXSourceTextAnchor new ]
]

{ #category : #accessing }
DPFragmentLocation >> fileAnchor: aFileAnchor [
	fileAnchor := aFileAnchor
]

{ #category : #testing }
DPFragmentLocation >> includesLocation: aFragmentLocation [
	^ self entity = aFragmentLocation entity
		and: [ 
			self locationFileName = aFragmentLocation locationFileName
				and: [ 
					(aFragmentLocation startLine between: self startLine and: self endLine)
						and: [ aFragmentLocation endLine between: self startLine and: self endLine ] ] ]
]

{ #category : #'class membership' }
DPFragmentLocation >> isMemberOf: aClonedFragment [
	^ self clonedFragment = aClonedFragment
]

{ #category : #accessing }
DPFragmentLocation >> length [
	^ self endLine - self startLine + 1
]

{ #category : #'as yet unclassified' }
DPFragmentLocation >> lineNumberCorrespondingToLine: anInteger [
	| entityBeginLine |
	entityBeginLine := self entity sourceAnchor fileReference contents
		lineNumberCorrespondingToIndex: self entity sourceAnchor startPos.
	^ entityBeginLine + anInteger - 1
]

{ #category : #accessing }
DPFragmentLocation >> locationFileName [
	^ self fileAnchor fileName
]

{ #category : #printing }
DPFragmentLocation >> mooseNameOn: stream [
	stream nextPutAll: 'Fragment in '.
	super mooseNameOn: stream
]

{ #category : #accessing }
DPFragmentLocation >> name [
	^ self entity ifNil: [ #undefined ] ifNotNil: #name
]

{ #category : #accessing }
DPFragmentLocation >> putIntoEntity [
	self entity addCloneLocation: self
]

{ #category : #accessing }
DPFragmentLocation >> sourceText [
	| source before beforeString after afterString textToRender |
	source := self entitySourceCode lines.
	before := source
		select: [ :l | (source indexOf: l) < self startLine ].
	beforeString := String
		streamContents: [ :stream | 
			before
				do: [ :line | 
					stream
						<< line;
						cr ] ].
	after := source select: [ :l | (source indexOf: l) > self endLine ].
	afterString := String
		streamContents: [ :stream | 
			after
				do: [ :line | 
					stream
						<< line;
						cr ] ].
	textToRender := Text new.
	textToRender append: beforeString.
	textToRender
		append:
			(Text
				string: self codeText
				attributes: {(TextColor new color: Color red)}).
	textToRender append: afterString.
	^ textToRender
]

{ #category : #accessing }
DPFragmentLocation >> startLine [
	<navigation: 'Starting line of code duplication'>
	^ startLine
]

{ #category : #accessing }
DPFragmentLocation >> startLine: anObject [
	startLine := anObject
]

{ #category : #'as yet unclassified' }
DPFragmentLocation >> startLineInOriginalFile [
	^ self lineNumberCorrespondingToLine: self startLine
]
