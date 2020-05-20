Class {
	#name : #PowerbuliderLocation,
	#superclass : #Object,
	#instVars : [
		'dupAloDupLocation',
		'clonedFragment'
	],
	#category : #'PowerBuilderAnalyzeTool-DuplicationGUI-Core'
}

{ #category : #accessing }
PowerbuliderLocation >> clonedFragment [
	^ clonedFragment
]

{ #category : #accessing }
PowerbuliderLocation >> clonedFragment: aPowerbuliderDuplicationSystem [
	clonedFragment := aPowerbuliderDuplicationSystem
]

{ #category : #accessing }
PowerbuliderLocation >> codeText [
	^ dupAloDupLocation codeText
]

{ #category : #accessing }
PowerbuliderLocation >> dupAloDupLocation: anAloDupLocation [
	dupAloDupLocation := anAloDupLocation
]

{ #category : #accessing }
PowerbuliderLocation >> endLine [
	^ dupAloDupLocation endLine
]

{ #category : #'accessing ' }
PowerbuliderLocation >> entity [
	^ dupAloDupLocation entity
]

{ #category : #accessing }
PowerbuliderLocation >> entitySourceCode [
	^ dupAloDupLocation entitySourceCode
]

{ #category : #'class membership' }
PowerbuliderLocation >> isMemberOf: aClonedFragment [
	^ self clonedFragment = aClonedFragment
]

{ #category : #accessing }
PowerbuliderLocation >> name [
	^ dupAloDupLocation name
]

{ #category : #accessing }
PowerbuliderLocation >> sourceText [
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
PowerbuliderLocation >> startLine [
	^ dupAloDupLocation startLine
]
