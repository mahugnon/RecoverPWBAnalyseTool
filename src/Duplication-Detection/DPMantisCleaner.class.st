"
Cleans mantis code of code separators, leading number and digits.

Instance Variables
	whiteSpaceCleaner:		<Object>

whiteSpaceCleaner
	- cleans white spaces

"
Class {
	#name : #DPMantisCleaner,
	#superclass : #DPAbstractCleaner,
	#category : #'Duplication-Detection'
}

{ #category : #actions }
DPMantisCleaner >> clean: text [
	
	^ (super clean: text) 
		withoutLeadingDigits
	 	copyReplaceAll: ($. asString) with: ''.
]

{ #category : #actions }
DPMantisCleaner >> isComment: aLine [
	^ aLine prefixMatchesRegex:  ' *[0-9]* *\.+!+'.
]
