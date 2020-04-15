"
An abstract class that provides methods for cleaning the code before passing to the clone detector. Every language or a family of languages override these methods to implement the  logic of cleaning. 
"
Class {
	#name : #DPAbstractCleaner,
	#superclass : #Object,
	#category : #'Duplication-Detection'
}

{ #category : #actions }
DPAbstractCleaner >> clean: text [
	^ {(String space).
	(String tab).
	(String cr).
	(String lf).
	(String crlf)} inject: text into: [ :crtLine :space | crtLine copyReplaceAll: space with: '' ]
]

{ #category : #actions }
DPAbstractCleaner >> isComment: aLine [
	self subclassResponsibility 
]

{ #category : #accessing }
DPAbstractCleaner >> reset [
	self initialize
]
