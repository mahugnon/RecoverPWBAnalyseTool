Extension { #name : #MooseModel }

{ #category : #'*Duplication' }
MooseModel >> dupDetectionParams [
	self subclassResponsibility
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
