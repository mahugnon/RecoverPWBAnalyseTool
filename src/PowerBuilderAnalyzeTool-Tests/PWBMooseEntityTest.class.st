Class {
	#name : #PWBMooseEntityTest,
	#superclass : #AbstractPWBCallTreeBrowserTest,
	#category : #'PowerBuilderAnalyzeTool-Tests'
}

{ #category : #tests }
PWBMooseEntityTest >> testIncomingAllInvocationsSenders [
	self
		assertCollection: testUserObject1 allIncomingInvocationsSenders
		hasSameElements:
			{testUserObject2.
			testUserObject3.
			testUserObject4}
]

{ #category : #tests }
PWBMooseEntityTest >> testIncomingInvocationsSenders [
	self
		assertCollection: testUserObject1 incomingInvocationsSenders
		hasSameElements: {testUserObject2}
]

{ #category : #tests }
PWBMooseEntityTest >> testQueryDeadArguments [
	self
		assertCollection:
			(QueryDeadArguments
				runOn:
					{testLocalVar3.
					testArg1})
		hasSameElements: {testArg1}
]

{ #category : #tests }
PWBMooseEntityTest >> testQueryDeadLocalVariables [
	self
		assertCollection:
			(QueryDeadLocalVariables
				runOn:
					{testLocalVar3.
					testArg1})
		hasSameElements: {testLocalVar3}
]

{ #category : #tests }
PWBMooseEntityTest >> testQueryDeadVariablesBehavioral [
	| behavioral |
	behavioral := QueryBehavioral
		runOn:
			{testLocalVar3.
			testArg1}.
	self
		assertCollection: behavioral
		hasSameElements:
			{testFunction1.
			testFunction2}.
	self assert: testFunction1 deadArguments anyOne equals: testArg1.
	self assert: testFunction1 deadLocalVariables isEmpty
]

{ #category : #tests }
PWBMooseEntityTest >> testQueryDeedAttributesVariables [
	| query |
	query := QueryDeadVariables runOn: testUserObject1.
	self
		assertCollection: query instanceVariables
		hasSameElements:
			{testInstVar3.
			testInstVar4}
]

{ #category : #tests }
PWBMooseEntityTest >> testQueryDeedVariables [
	| query |
	query := QueryDeadVariables runOn: testUserObject1.
	self
		assertCollection: query variables
		hasSameElements:
			{testLocalVar3.
			testArg1}
]

{ #category : #tests }
PWBMooseEntityTest >> testQueryIncomingInvocationsSendersAtLevel [
	self
		assertCollection: (testUserObject1 incomingInvocationsSenders: 2)
		hasSameElements:
			{testUserObject2.
			testUserObject3}
]

{ #category : #tests }
PWBMooseEntityTest >> testQueryIncomingInvocationsSendersAtLevel2Strategy [
	| option |
	option := OptionParameters new
		maxLevel: 2;
		action: InvocationAtLevelOption;
		yourself.
	self
		assertCollection:
			((QueryIncomingInvocationSenders options: option)
				runOn: testUserObject1)
		hasSameElements:
			{testUserObject2.
			testUserObject3}
]

{ #category : #tests }
PWBMooseEntityTest >> testQueryIncomingInvocationsSendersWithEntityStrategy1 [
	| option |
	option := OptionParameters new
		action: InvocationWithEntitiesOption ;
		yourself.
	self
		assertCollection:
			((QueryIncomingInvocationSenders options: option)
				runOn: testUserObject1)
		hasSameElements: {testUserObject2}
]

{ #category : #tests }
PWBMooseEntityTest >> testQueryIncomingInvocationsSendersWithEntityStrategy2 [
	| option |
	option := OptionParameters new
		action: InvocationWithEntitiesOption ;
		yourself.
	option addEntity: testUserObject2.
	self
		assertCollection:
			((QueryIncomingInvocationSenders options: option)
				runOn: testUserObject1)
		hasSameElements:
			{testUserObject2.
			testUserObject3}
]
