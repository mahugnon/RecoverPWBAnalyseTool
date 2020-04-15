"
The cleaner cleans smalltalk method code for duplication detection.
"
Class {
	#name : #DPSmalltalkCleaner,
	#superclass : #DPAbstractCleaner,
	#category : #'Duplication-Detection'
}

{ #category : #'as yet unclassified' }
DPSmalltalkCleaner >> clean: aText [
	^ (super clean: aText) copyWithRegex:  '\".*\"'  matchesReplacedWith: ''
]

{ #category : #'as yet unclassified' }
DPSmalltalkCleaner >> isComment: aLine [
	"we could have defined comment as 
		aLine matchesRegex:  '\"".*\""$' 
	but just returning false because a comment line will be empty because cleaner removes everything within double qoutes and hence not considered by the detector"
	^ false
]
