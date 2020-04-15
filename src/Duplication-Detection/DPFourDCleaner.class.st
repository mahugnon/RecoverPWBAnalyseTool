"
cleaning mechanism for 4D language.
Comments in 4D start with //
"
Class {
	#name : #DPFourDCleaner,
	#superclass : #DPAbstractCleaner,
	#category : #'Duplication-Detection'
}

{ #category : #actions }
DPFourDCleaner >> isComment: aLine [
	^ aLine prefixMatchesRegex:  ' */'.
]
