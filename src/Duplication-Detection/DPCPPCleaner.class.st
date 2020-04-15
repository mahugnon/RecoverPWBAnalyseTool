"
clearner for CPP language.
To do: multiple line comments
"
Class {
	#name : #DPCPPCleaner,
	#superclass : #DPAbstractCleaner,
	#category : #'Duplication-Detection'
}

{ #category : #actions }
DPCPPCleaner >> clean: aText [
	"a++ //asd -> a++"

	^ (super clean: aText) copyUpToSubString: '//'
]

{ #category : #testing }
DPCPPCleaner >> isComment: aLine [
	"return false because commented code is replaced with empty string"

	^ false
]
