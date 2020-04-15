Extension { #name : #MooseModel }

{ #category : #'*Duplication' }
MooseModel >> dupDetectionParams [
	self subclassResponsibility
]

{ #category : #'*Duplication' }
MooseModel >> duplicationRate [
	"I return a metric that correspond to the percentage of duplication in the code."

	^ self
		lookUpPropertyNamed: #duplicationRate
		computedAs: [ 
			[ self entitiesForDupDetection average: #duplicationRate ]
				on: ZeroDivide
				do: [ SYNUnavailableMetric  ] ]
]

{ #category : #'*Duplication' }
MooseModel >> entitiesForDupDetection [
	^ self allContainers
]

{ #category : #'*Duplication' }
MooseModel >> initializeDups [
	self clearDuplicationSystem.
	self dupSys: (DPDetector runOn: self entitiesForDupDetection parametrizedWith: self dupDetectionParams)
]
