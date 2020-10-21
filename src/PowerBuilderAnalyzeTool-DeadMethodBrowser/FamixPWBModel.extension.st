Extension { #name : #FamixPWBModel }

{ #category : #'*PowerBuilderAnalyzeTool-DeadMethodBrowser' }
FamixPWBModel >> allContainersWithDuplicatedCode [
	^ self allModelEntities
		select: [ :entity | entity cloneLocations isNotEmpty ]
]

{ #category : #'*PowerBuilderAnalyzeTool-DeadMethodBrowser' }
FamixPWBModel >> allModelAliveMethods [
	^ self allMethods asSet select: [ :method | method isNotPWBDead ]
]

{ #category : #'*PowerBuilderAnalyzeTool-DeadMethodBrowser' }
FamixPWBModel >> allModelDeadMethodWithAliveStrategy [
	self killIncrementallyNonInvocatedMethods.
	^ self allMethods asSet select: [ :method | method isPWBDead ]
]

{ #category : #'*PowerBuilderAnalyzeTool-DeadMethodBrowser' }
FamixPWBModel >> allModelDeadMethods [
	self resurrectMethods.
	^ self allMethods asSet select: #isPWBDead
]

{ #category : #'*PowerBuilderAnalyzeTool-DeadMethodBrowser' }
FamixPWBModel >> dupSys: aDPDuplicationSystem [
	self privateState attributeAt: #dupSys put: aDPDuplicationSystem
]

{ #category : #'*PowerBuilderAnalyzeTool-DeadMethodBrowser' }
FamixPWBModel >> extractVariables: aCollectionOfPWBObjects [
	| variables |
	variables := aCollectionOfPWBObjects
		flatCollectAsSet:
			[ :each | each attributes select: [ :e | e accessingMethods isNotEmpty ] ].
	^ variables
]

{ #category : #'*PowerBuilderAnalyzeTool-DeadMethodBrowser' }
FamixPWBModel >> initializeMethodsToAlive [
	self allMethods asSet
		do: [ :method | 
			method isPWBDead
				ifTrue: [ method isPWBDead: false ] ]
]

{ #category : #'*PowerBuilderAnalyzeTool-DeadMethodBrowser' }
FamixPWBModel >> initializeMethodsToDeath [
	((self allMethods asSet reject: #isPredefinedMethod)
		reject: [ :m | 
			{FamixPWBEvent.
			FamixPWBTrigger} includes: m class ])
		do: [ :m | m isPWBDead: true ]
]

{ #category : #'*PowerBuilderAnalyzeTool-DeadMethodBrowser' }
FamixPWBModel >> install [
	super install.
	self resurrectMethods
]

{ #category : #'*PowerBuilderAnalyzeTool-DeadMethodBrowser' }
FamixPWBModel >> killIncrementallyNonInvocatedMethods [
	| defaultAlive deadMethods done |
	self initializeMethodsToAlive.
	defaultAlive := QueryDefaultAliveMethods runOn: self allMethods asSet.
	QueryDirectDeadMethods runOn: self allMethods asSet.
	deadMethods := self allMethods asSet
		select: [ :method | method isPWBDead ].
	done := false.
	[ done ]
		whileFalse: [ | modelDeadMethods |
			deadMethods
				do: [ :dead | 
					| potentialDead deadFounded |
					potentialDead := dead outgoingInvocationsCandidates
						reject: [ :meth | meth isPWBDead or: [ defaultAlive includes: meth ] ].
					deadFounded := potentialDead
						reject:
							[ :aMethod | aMethod incomingInvocationsSenders anySatisfy: #isNotPWBDead ].
					deadFounded
						ifNotEmpty: [ deadFounded do: [ :m | m isPWBDead: true ] ] ].
			modelDeadMethods := self allMethods asSet
				select: [ :method | method isPWBDead ].
			deadMethods = modelDeadMethods
				ifTrue: [ done := true ]
				ifFalse: [ deadMethods := modelDeadMethods ] ]
]

{ #category : #'*PowerBuilderAnalyzeTool-DeadMethodBrowser' }
FamixPWBModel >> resetDeathMethodState [
	self allMethods asSet do: [ :method | method isPWBDead: false ]
]

{ #category : #'*PowerBuilderAnalyzeTool-DeadMethodBrowser' }
FamixPWBModel >> resurrectMethods [
	| alive end |
	self initializeMethodsToDeath.
	end := false.
	alive := self allModelAliveMethods.
	[ end ]
		whileFalse: [ alive
				do: [ :each | 
					(each outgoingInvocationsCandidates reject: #isNotPWBDead)
						do: [ :toResurect | toResurect isPWBDead: false ] ].
			alive = self allModelAliveMethods
				ifTrue: [ end := true ]
				ifFalse: [ alive := self allModelAliveMethods ] ]
]

{ #category : #'*PowerBuilderAnalyzeTool-DeadMethodBrowser' }
FamixPWBModel >> selectIncomingInvocationMethodsUntilConvergence: aCollection [
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
