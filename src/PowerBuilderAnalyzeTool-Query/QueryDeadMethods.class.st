Class {
	#name : #QueryDeadMethods,
	#superclass : #AbstractPWBQuery,
	#instVars : [
		'modelInvocation'
	],
	#category : #'PowerBuilderAnalyzeTool-Query'
}

{ #category : #running }
QueryDeadMethods >> checkPotentialSendersTo: aFamixPWBMethod [
	^ modelInvocation
		select: [ :inv | 
			(inv candidates
				anySatisfy: [ :candidate | candidate name = aFamixPWBMethod name ])
				and: [ inv sender isNotPWBDead ] ]
]

{ #category : #running }
QueryDeadMethods >> runOn: aFamixmajorObject [
	self flag: #ThisQueryShouldNotBeUsed.
	"After fixing bugs in the model invocations, this query should be remove"
	modelInvocation := aFamixmajorObject mooseModel allInvocations asSet.
	aFamixmajorObject deadMethods
		do: [ :aFamixPWBMethod | 
			(self checkPotentialSendersTo: aFamixPWBMethod)
				ifNotEmpty: [ aFamixPWBMethod isPWBDead: false ] ].
	aFamixmajorObject deadMethods
		do: [ :meth | 
			(meth incomingInvocationsSenders anySatisfy: #isNotPWBDead)
				ifTrue: [ meth isPWBDead: false ] ].
	^ aFamixmajorObject deadMethods
]
