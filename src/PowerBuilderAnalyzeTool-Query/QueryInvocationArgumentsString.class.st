Class {
	#name : #QueryInvocationArgumentsString,
	#superclass : #AbstractPWBQuery,
	#category : #'PowerBuilderAnalyzeTool-Query'
}

{ #category : #running }
QueryInvocationArgumentsString >> runOn: anInvocation [
	| invString |
	invString := '(' split: anInvocation sourceText.
	invString size < 2
		ifTrue: [ ^ '()' ].
	^ '(' , ('(' split: anInvocation sourceText) second
]
