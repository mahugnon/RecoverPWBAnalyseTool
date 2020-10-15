Class {
	#name : #QueryBRFunctionsFromKnownPoint,
	#superclass : #AbstractPWBQuery,
	#category : #'PowerBuilderAnalyzeTool-Query'
}

{ #category : #running }
QueryBRFunctionsFromKnownPoint >> extractVariables: aCollectionOfPWBObjects [
	| variables |
	variables := aCollectionOfPWBObjects
		flatCollectAsSet:
			[ :each | each attributes select: [ :e | e accessingMethods isNotEmpty ] ].
	^ variables
]

{ #category : #running }
QueryBRFunctionsFromKnownPoint >> runOn1: aCollectionOfPWBObjects [
	^ self
		selectIncomingInvocationMethodsUntilConvergence: (self extractVariables: aCollectionOfPWBObjects)
]

{ #category : #running }
QueryBRFunctionsFromKnownPoint >> runOn: aCollectionOfPWBmajorObjects [
	^ self
		selectIncomingInvocationMethodsUntilConvergence2: (self extractVariables: aCollectionOfPWBmajorObjects)
]

{ #category : #running }
QueryBRFunctionsFromKnownPoint >> selectIncomingInvocationMethodsUntilConvergence2: aCollection [
	| methods stop |
	methods := (aCollection flatCollectAsSet: [ :e | e accessingMethods ])
		reject: [ :e | e isKindOf: FamixPWBmajorObject ].
	stop := 0.
	[ stop = methods size ]
		whileFalse: [ stop := methods size.
			methods := methods
				addAll: (methods flatCollectAsSet: [ :m | m invokedMethods ]) ].
	^ (methods reject: [ :behavioral | behavioral parentType isNil ])
		sortDescending: [ :e | e numberOfLinesOfCode + e cyclomaticComplexity ]
]

{ #category : #running }
QueryBRFunctionsFromKnownPoint >> selectIncomingInvocationMethodsUntilConvergence: aCollection [
	| methods stop |
	methods := ((aCollection
		flatCollectAsSet: [ :e | e accessingMethods ])
		reject: [ :e | e isPWBClass ]) asSet.
	stop := 0.
	[ stop = methods size ]
		whileFalse: [ stop := methods size.
			methods
				addAll: (methods flatCollectAsSet: [ :m | m invokedMethods ]) ].
	^ methods
		select:
			[ :behavioral | behavioral parentType isNotNil and: [ behavioral isFunction ] ]
]
