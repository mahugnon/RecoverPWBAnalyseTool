"
List of parameters needed for duplication system.

Cleaner: the cleaner used to clean the code before detecting duplication.
frequency: the number of times a snippet is cloned. For example, correcting those copied ten times have much more impact on code quality than those copied only twice.
minNumberOfCharacters: minimum number of characters in clone fragment. Too small code fragment are not interesting.
minNumberOfLines: minimum number of lines of code. It is important not to report all the duplication but those which have a certain size.
selectedPrograms: programs selected by the user to check for duplication.

"
Class {
	#name : #DPParameters,
	#superclass : #Object,
	#instVars : [
		'minNumberOfLines',
		'minNumberOfCharacters',
		'frequency',
		'cleaner'
	],
	#category : #'Duplication-Detection'
}

{ #category : #accessing }
DPParameters >> cleaner [
	^ cleaner
]

{ #category : #accessing }
DPParameters >> cleaner: anObject [
	cleaner := anObject
]

{ #category : #accessing }
DPParameters >> frequency [
	^ frequency
]

{ #category : #accessing }
DPParameters >> frequency: anObject [
	frequency := anObject
]

{ #category : #accessing }
DPParameters >> minNumberOfCharacters [
	^ minNumberOfCharacters
]

{ #category : #accessing }
DPParameters >> minNumberOfCharacters: anObject [
	minNumberOfCharacters := anObject
]

{ #category : #accessing }
DPParameters >> minNumberOfLines [
	^ minNumberOfLines
]

{ #category : #accessing }
DPParameters >> minNumberOfLines: anObject [
	minNumberOfLines := anObject
]
