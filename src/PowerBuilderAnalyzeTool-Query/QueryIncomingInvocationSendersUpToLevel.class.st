Class {
	#name : #QueryIncomingInvocationSendersUpToLevel,
	#superclass : #QueryIncomingInvocationSenders,
	#category : #'PowerBuilderAnalyzeTool-Query'
}

{ #category : #visiting }
QueryIncomingInvocationSendersUpToLevel class >> accept: anObject [
	^ anObject = InvocationAtLevelOption
]

{ #category : #running }
QueryIncomingInvocationSendersUpToLevel >> runOn: anEntity [
	^ anEntity
		incomingInvocationsSenders: options maxLevel
		exceptFromMethodsOfType: #()
]
