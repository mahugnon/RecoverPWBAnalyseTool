Extension { #name : #FamixPWBmajorObject }

{ #category : #'*PowerBuilderAnalyzeTool' }
FamixPWBmajorObject >> incomingInvocationsSenders: anInteger [
	| totalResult levelResult level scan |
	totalResult := self incomingInvocationsSenders.
	levelResult := totalResult.
	level := 1.
	scan := 0.
	[ level < anInteger and: [ scan < totalResult size ] ]
		whileTrue: [ level := level + 1.
			scan := totalResult size.
			levelResult := levelResult flatCollect: #incomingInvocationsSenders.
			totalResult addAll: levelResult ].
	^ totalResult asOrderedCollection
]

{ #category : #'*PowerBuilderAnalyzeTool' }
FamixPWBmajorObject >> incomingInvocationsSenders: anInteger expectFromMethodsOfType: aCollection [
	| totalResult levelResult level scan |
	totalResult := self
		incomingInvocationsSendersExpectFromMethodsOfType: aCollection.
	levelResult := totalResult.
	level := 1.
	scan := 0.
	[ level < anInteger and: [ scan < totalResult size ] ]
		whileTrue: [ level := level + 1.
			scan := totalResult size.
			totalResult := levelResult
				flatCollectAsSet:
					[ :each | each incomingInvocationsSendersExpectFromMethodsOfType: aCollection ].
			totalResult addAll: levelResult ].
	^ totalResult asSet
]

{ #category : #'*PowerBuilderAnalyzeTool' }
FamixPWBmajorObject >> incomingInvocationsSendersWith: aCollection [
	| result |
	result := self incomingInvocationsSenders.
	result addAll: (aCollection flatCollect: #incomingInvocationsSenders).
	^ result asOrderedCollection
]

{ #category : #'*PowerBuilderAnalyzeTool' }
FamixPWBmajorObject >> methodsInvocationsSendersTypes [
	^ self methodsIncomingInvocationsSenders collectAsSet: #class
]

{ #category : #'*PowerBuilderAnalyzeTool' }
FamixPWBmajorObject >> printString [
	^ self name
]
