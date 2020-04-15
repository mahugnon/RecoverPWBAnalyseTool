Class {
	#name : #PWBPresenter,
	#superclass : #SpPresenter,
	#category : #'PowerBuilderAnalyzeTool-Core'
}

{ #category : #'as yet unclassified' }
PWBPresenter class >> currentApplication [
	^ PWBApplication current
]

{ #category : #'instance creation' }
PWBPresenter class >> new [
	self flag: #Todo."With the next version of spec this will not be needed as it will just take the current application"
	^ self newApplication: self currentApplication
]

{ #category : #'instance creation' }
PWBPresenter class >> on: anObject [
	self flag: #Todo.	"With the next version of spec this will not be needed as it will just take the current application"
	^ self newApplication: self currentApplication model: anObject
]

{ #category : #'instance creation' }
PWBPresenter class >> owner: anOwningPresenter [
	self flag: #Todo.	"With the next version of spec this will not be needed as it will just take the current application"
	^ self newApplication: self currentApplication owner: anOwningPresenter
]

{ #category : #'instance creation' }
PWBPresenter class >> owner: anOwningPresenter on: aDomainObject [
	self flag: #Todo.	"With the next version of spec this will not be needed as it will just take the current application"
	^ self
		newApplication: self currentApplication
		owner: anOwningPresenter
		model: aDomainObject
]

{ #category : #testing }
PWBPresenter >> isPWBBrowser [
	^ false
]
