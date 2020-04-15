Class {
	#name : #QueryIncomingInvocationSenders,
	#superclass : #AbstractPWBQuery,
	#instVars : [
		'options'
	],
	#category : #'PowerBuilderAnalyzeTool-Query'
}

{ #category : #visiting }
QueryIncomingInvocationSenders class >> accept: aString [
	^ self subclassResponsibility
]

{ #category : #accessing }
QueryIncomingInvocationSenders class >> options: anOptionParameters [
	^ (self subclasses
		detect: [ :sub | sub accept: anOptionParameters action ]) new
		options: anOptionParameters
]

{ #category : #accessing }
QueryIncomingInvocationSenders >> options: anOptionParameters [ 
	options := anOptionParameters
]
