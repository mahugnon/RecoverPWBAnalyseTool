"
logic of cleaning for cobol.
Cobol has several divisons and the procedure divison contains the code. The division starts from the column 72.
"
Class {
	#name : #DPCobolCleaner,
	#superclass : #DPAbstractCleaner,
	#instVars : [
		'insideProcedureDivision'
	],
	#category : #'Duplication-Detection'
}

{ #category : #actions }
DPCobolCleaner >> clean: text [
	^ (self insideProcedureDivision)
		ifFalse: [ 
			('###### *PROCEDURE *DIVISION*' match: text) ifTrue: [ self insideProcedureDivision: true ].
			'' ]
		ifTrue: [ (text size >= self endPosFirstCommentColumn) ifTrue: [
					(text size >= self startPosSecondCommentColumn)
						ifTrue: [ (super clean: (text copyFrom: self endPosFirstCommentColumn to: self startPosSecondCommentColumn)) ]
						ifFalse: [ (super clean: (text copyFrom: self endPosFirstCommentColumn to: text size)) ] ]
					ifFalse: [ '' ] ]
]

{ #category : #accessing }
DPCobolCleaner >> endPosFirstCommentColumn [
	^7
]

{ #category : #'initialize-release' }
DPCobolCleaner >> initialize [ 
	self insideProcedureDivision: false
]

{ #category : #accessing }
DPCobolCleaner >> insideProcedureDivision [
	^ insideProcedureDivision
]

{ #category : #accessing }
DPCobolCleaner >> insideProcedureDivision: anObject [
	insideProcedureDivision := anObject
]

{ #category : #actions }
DPCobolCleaner >> isComment: aLine [
	^ (aLine notEmpty) and: [aLine first = $*]

	
]

{ #category : #accessing }
DPCobolCleaner >> startPosSecondCommentColumn [
	^72
]
