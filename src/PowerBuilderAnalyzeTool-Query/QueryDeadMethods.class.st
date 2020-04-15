Class {
	#name : #QueryDeadMethods,
	#superclass : #AbstractPWBQuery,
	#instVars : [
		'entityMethods'
	],
	#category : #'PowerBuilderAnalyzeTool-Query'
}

{ #category : #'as yet unclassified' }
QueryDeadMethods >> filterFounded: aCollection [
	^ aCollection
		reject: [ :each | 
			(entityMethods
				select: [ :e | 
					(e outgoingInvocations
						flatCollect: [ :invocation | invocation candidates collectAsSet: #name ])
						includes: each name ]) isNotEmpty ]
]

{ #category : #running }
QueryDeadMethods >> runOn: anObject [
	entityMethods := anObject methods asSet
		reject: [ :each | each name = 'constructor' ].
	^ self filterFounded: self searchDeadMethod
]

{ #category : #running }
QueryDeadMethods >> searchDeadMethod [
	^ entityMethods
		select: [ :method | 
			method outgoingInvocations isEmpty
				and: [ method incomingInvocations isEmpty ] ]
]

{ #category : #running }
QueryDeadMethods >> toSkip [
	^ {'constructor'}
]
