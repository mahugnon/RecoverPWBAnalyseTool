Class {
	#name : #QueryIncomingInvocationSendersFilterByMethodsTypeUpToLevel,
	#superclass : #QueryIncomingInvocationSenders,
	#category : #'PowerBuilderAnalyzeTool-Query'
}

{ #category : #visiting }
QueryIncomingInvocationSendersFilterByMethodsTypeUpToLevel class >> accept: anObject [
	^ anObject = FilterConsideredMethodTypeOption
]

{ #category : #running }
QueryIncomingInvocationSendersFilterByMethodsTypeUpToLevel >> runOn: anEntity [
	^ anEntity
		incomingInvocationsSenders: options maxLevel
		exceptFromMethodsOfType: options typeToFilter
]
