"
Ada comment lines start with --.
"
Class {
	#name : #DPAdaCleaner,
	#superclass : #DPAbstractCleaner,
	#classVars : [
		'CommentRegex'
	],
	#category : #'Duplication-Detection'
}

{ #category : #accessing }
DPAdaCleaner class >> commentRegex [
	^ CommentRegex ifNil: [ CommentRegex := '--*' asRegex ]
]

{ #category : #actions }
DPAdaCleaner >> clean: aText [
	"a++ //asd -> a++"

	^ (super clean: aText) copyUpToSubString: '--'
]

{ #category : #actions }
DPAdaCleaner >> isComment: aLine [
	^ self class commentRegex matchesPrefix: aLine
]
