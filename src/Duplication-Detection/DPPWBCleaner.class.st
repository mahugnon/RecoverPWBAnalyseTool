Class {
	#name : #DPPWBCleaner,
	#superclass : #DPAbstractCleaner,
	#classVars : [
		'CommentRegex'
	],
	#category : #'Duplication-Detection'
}

{ #category : #actions }
DPPWBCleaner >> isComment: aLine [
  ^false
]
