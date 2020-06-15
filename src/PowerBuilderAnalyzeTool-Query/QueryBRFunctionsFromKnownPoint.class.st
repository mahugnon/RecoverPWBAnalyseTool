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
	self selectIncomingInvocationMethodsUntilConvergence: methods
]

{ #category : #running }
QueryBRFunctionsFromKnownPoint >> selectIncomingInvocationMethodsUntilConvergence: methods [
	| converge |
	converge := false.
	[ converge ]
		whileFalse: [ | invocationMethods |
			invocationMethods := Set
				withAll:
					methods
						,
							(methods
								flatCollectAsSet: [ :m | 
									(m queryAllIncomingInvocations
										reject: [ :e | e class usesFamixTrait: FamixTAccess ])
										collect: #sender ]).
			invocationMethods size = methods size
				ifTrue: [ converge := true ]
				ifFalse: [ methods = invocationMethods ] ]
]
