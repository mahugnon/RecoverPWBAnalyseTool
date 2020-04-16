Class {
	#name : #DeadMethodsTests,
	#superclass : #PWBBrowsersAbstractTest,
	#instVars : [
		'testEvent1',
		'testTrigger1'
	],
	#category : #'PowerBuilderAnalyzeTool-Tests'
}

{ #category : #initialization }
DeadMethodsTests >> initializeEvents [
	testEvent1 := FamixPWBEvent new
		name: 'testEvent1';
		parentType: testUserObject6;
		yourself.
	testModel add: testEvent1.
	testTrigger1 := FamixPWBTrigger new
		name: 'testTrigger1';
		parentType: testUserObject6;
		yourself.
	testModel add: testTrigger1
]

{ #category : #initialization }
DeadMethodsTests >> setUp [
	super setUp.
	FamixPWBInvocation new
		mooseModel: testModel;
		sender: testFunction7;
		candidates: {testFunction2}.
	self initializeEvents.
	FamixPWBInvocation new
		mooseModel: testModel;
		sender: testEvent1;
		candidates: {testFunction4}.
	FamixPWBInvocation new
		mooseModel: testModel;
		sender: testTrigger1;
		candidates: {testFunction9}.
	browser := PWBDeadMethodsBrowser new
]

{ #category : #initialization }
DeadMethodsTests >> testBrowserShouldNotUpdateOnMooseGroup [
	| group |
	group := {testUserObject1.
	testUserObject2} asMooseGroup.
	browser selectEntity: group.
	self assert: browser selected ~= group
]

{ #category : #initialization }
DeadMethodsTests >> testDeadMethodsStrategy1 [
self
		assertCollection: testModel allModelDeadMethods
		hasSameElements:
			{testFunction8.
			testFunction7.
			testFunction2.
			testFunction10.
			testFunction5.
			testFunction3.
			testFunction6}
]

{ #category : #initialization }
DeadMethodsTests >> testQueryDirectDeadMethods [
	| directDeadMethods |
	directDeadMethods := QueryDirectDeadMethods
		runOn:
			{testFunction1.
			testFunction2.
			testFunction4.
			testFunction8.
			testFunction7.
			testEvent1}.
	self
		assertCollection: directDeadMethods
		hasSameElements: {testFunction8}
]

{ #category : #initialization }
DeadMethodsTests >> testQueryDiscoverDeadMethodsIncrementally [
	self
		assertCollection: testModel allModelDeadMethodWithAliveStrategy
		hasSameElements:
			{testFunction8.
			testFunction7.
			testFunction2.
			testFunction10.
			testFunction5.
			testFunction3.
			testFunction6}
]

{ #category : #initialization }
DeadMethodsTests >> testQueryInitDeathState [
	self
		assert: (testModel allMethods collectAsSet: #isPWBDead) anyOne
		equals: false
]

{ #category : #tests }
DeadMethodsTests >> test_testObject1_has_4_deadMethods [
	testModel resurrectMethods.
	self
		assertCollection: testUserObject1 deadMethods
		hasSameElements:
			{testFunction2.
			testFunction3.
			testFunction5.
			testFunction10}
]
