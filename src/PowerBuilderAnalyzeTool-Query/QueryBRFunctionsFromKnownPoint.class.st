Class {
	#name : #QueryBRFunctionsFromKnownPoint,
	#superclass : #AbstractPWBQuery,
	#category : #'PowerBuilderAnalyzeTool-Query'
}

{ #category : #running }
QueryBRFunctionsFromKnownPoint >> extractVariables: aCollectionOfPWBObjects [
	| variables |
	variables := aCollectionOfPWBObjects
		flatCollectAsSet: [ :each | 
			{each attributes.
			(each methods flatCollectAsSet: #variables)} flatten
				select: [ :e | e accessingMethods isNotEmpty ] ].
	^ variables
]

{ #category : #running }
QueryBRFunctionsFromKnownPoint >> runOn: aCollectionOfPWBObjects [
	| methods |
	methods := (self extractVariables: aCollectionOfPWBObjects)
		flatCollectAsSet: #accessingMethods.
	^ self selectIncomingInvocationMethodsUntilConvergence: methods
]

{ #category : #running }
QueryBRFunctionsFromKnownPoint >> selectIncomingInvocationMethodsUntilConvergence: methods [
	| converge convergingMethods |
	converge := false.
	convergingMethods := methods.
	[ converge ]
		whileFalse: [ | invocationMethods |
			invocationMethods := Set
				withAll:
					convergingMethods
						,
							(convergingMethods
								flatCollectAsSet: [ :m | 
									(m queryAllIncomingInvocations
										reject: [ :e | e class usesFamixTrait: FamixTAccess ])
										collect: #sender ]).
			invocationMethods size = convergingMethods size
				ifTrue: [ converge := true ]
				ifFalse: [ convergingMethods := invocationMethods ] ].
	^ convergingMethods
]
