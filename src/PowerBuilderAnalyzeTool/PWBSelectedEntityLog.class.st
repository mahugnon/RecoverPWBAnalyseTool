Class {
	#name : #PWBSelectedEntityLog,
	#superclass : #PWBLog,
	#instVars : [
		'entity'
	],
	#category : #'PowerBuilderAnalyzeTool-Core'
}

{ #category : #accessing }
PWBSelectedEntityLog class >> entity: aSelectedEntity [
	^ self new entity: aSelectedEntity
]

{ #category : #activation }
PWBSelectedEntityLog >> activate [
	self application refreshBrowsersWith: self entity
]

{ #category : #activation }
PWBSelectedEntityLog >> entity [
	^ entity
]

{ #category : #accessor }
PWBSelectedEntityLog >> entity: aSelectedEntity [
	entity := aSelectedEntity.
	time := DateAndTime now.
	self activate
]

{ #category : #printing }
PWBSelectedEntityLog >> printString [
	^ Text new
		append: entity name , '  ';
		append:
			(Text
				string: time epiceaBrowsersAsString
				attributes: {(TextColor new color: Color blue)});
		yourself
]
