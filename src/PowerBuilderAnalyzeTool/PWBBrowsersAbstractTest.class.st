Class {
	#name : #PWBBrowsersAbstractTest,
	#superclass : #TestCase,
	#instVars : [
		'testModel',
		'testUserObject1',
		'testUserObject2',
		'testUserObject3',
		'testUserObject4',
		'testUserObject5',
		'testUserObject6',
		'testFunction1',
		'testFunction2',
		'testFunction3',
		'testFunction4',
		'testFunction5',
		'testFunction6',
		'testFunction7',
		'testFunction8',
		'testFunction9',
		'testFunction10',
		'testInstVar1',
		'testInstVar2',
		'testInstVar3',
		'testInstVar4',
		'testLocalVar1',
		'testLocalVar2',
		'testLocalVar3',
		'testLocalVar4',
		'testArg1',
		'testArg2',
		'browser'
	],
	#category : #'PowerBuilderAnalyzeTool-Tests'
}

{ #category : #initialization }
PWBBrowsersAbstractTest >> initializeAccess [
	testModel
		add:
			(FamixPWBVariableAccess new
				accessor: testFunction10;
				variable: testInstVar1).
	testModel
		add:
			(FamixPWBVariableAccess new
				accessor: testFunction10;
				variable: testInstVar2).
	testModel
		add:
			(FamixPWBVariableAccess new
				accessor: testFunction5;
				variable: testLocalVar4).
	testModel
		add:
			(FamixPWBVariableAccess new
				accessor: testFunction10;
				variable: testLocalVar2).
	testModel
		add:
			(FamixPWBVariableAccess new
				accessor: testFunction8;
				variable: testLocalVar1).
	testModel
		add:
			(FamixPWBVariableAccess new
				accessor: testFunction7;
				variable: testArg2)
]

{ #category : #initialization }
PWBBrowsersAbstractTest >> initializeInvocations [
	FamixPWBInvocation new
		mooseModel: testModel;
		sender: testFunction4;
		candidates: {testFunction1}.
	FamixPWBInvocation new
		mooseModel: testModel;
		sender: testFunction7;
		candidates: {testFunction4}.
	FamixPWBInvocation new
		mooseModel: testModel;
		sender: testFunction8;
		candidates: {testFunction7}
]

{ #category : #initialization }
PWBBrowsersAbstractTest >> initializeTestFunctions [
	testFunction1 := FamixPWBFunction new
		parentType: testUserObject1;
		name: 'testFunction1'.
	testFunction2 := FamixPWBFunction new
		parentType: testUserObject1;
		name: 'testFunction2'.
	testFunction3 := FamixPWBFunction new
		parentType: testUserObject1;
		name: 'testFunction3'.
"	testFunction1 := FamixPWBFunction new
		parentType: testUserObject1;
		name: 'testFunction1'."
	testFunction4 := FamixPWBFunction new
		parentType: testUserObject2;
		name: 'testFunction4'.
	testFunction5 := FamixPWBFunction new
		parentType: testUserObject1;
		name: 'testFunction5'.
	testFunction6 := FamixPWBFunction new
		parentType: testUserObject2;
		name: 'testFunction6'.
	"testFunction1 := FamixPWBFunction new
		parentType: testUserObject1;
		name: 'testFunction1'."
	testFunction7 := FamixPWBFunction new
		parentType: testUserObject3;
		name: 'testFunction7'.
	testFunction8 := FamixPWBFunction new
		parentType: testUserObject4;
		name: 'testFunction8'.
	testFunction9 := FamixPWBFunction new
		parentType: testUserObject1;
		name: 'testFunction9'.
	testFunction10 := FamixPWBFunction new
		parentType: testUserObject1;
		name: 'testFunction10'.
	testModel
		addAll:
			{testFunction1.
			testFunction2.
			testFunction3.
			testFunction4.
			testFunction5.
			testFunction6.
			testFunction7.
			testFunction8.
			testFunction9.
			testFunction10}
]

{ #category : #initialization }
PWBBrowsersAbstractTest >> initializeTestUserObject [
	testUserObject1 := testModel
		add: (FamixPWBUserObject new name: 'testUserObject1').
	testUserObject2 := testModel
		add: (FamixPWBUserObject new name: 'testUserObject2').
	testUserObject3 := testModel
		add: (FamixPWBUserObject new name: 'testUserObject3').
	testUserObject4 := testModel
		add: (FamixPWBUserObject new name: 'testUserObject4').
	testUserObject5 := testModel
		add: (FamixPWBUserObject new name: 'testUserObject5').
	testUserObject6 := testModel
		add: (FamixPWBUserObject new name: 'testUserObject6')
]

{ #category : #initialization }
PWBBrowsersAbstractTest >> initializeVariables [
	testInstVar1 := FamixPWBAttribute new
		name: 'iTestInstVar1';
		parentType: testUserObject1.
	testModel add: testInstVar1.
	testInstVar2 := FamixPWBAttribute new
		name: 'iTestInstVar2';
		parentType: testUserObject1.
	testModel add: testInstVar2.
	testInstVar3 := FamixPWBAttribute new
		name: 'iTestInstVar3';
		parentType: testUserObject1.
	testModel add: testInstVar3.
	testInstVar4 := FamixPWBAttribute new
		name: 'iTestInstVar4';
		parentType: testUserObject1.
	testModel add: testInstVar4.
	testLocalVar1 := FamixPWBVariable new
		name: 'ltestLocalVar1';
		behavioral: testFunction1.
	testModel add: testLocalVar1.
	testLocalVar2 := FamixPWBVariable new
		name: 'ltestLocalVar2';
		behavioral: testFunction1.
	testModel add: testLocalVar2.
	testLocalVar3 := FamixPWBVariable new
		name: 'ltestLocalVar3';
		behavioral: testFunction2.
	testModel add: testLocalVar3.
	testLocalVar4 := FamixPWBVariable new
		name: 'ltestLocalVar4';
		behavioral: testFunction4.
	testModel add: testLocalVar4.
	testArg1 := FamixPWBVariable new
		name: 'atestArg1';
		behavioral: testFunction1.
	testModel add: testArg1.
	testArg2 := FamixPWBVariable new
		name: 'atestArg2';
		behavioral: testFunction1.
	testModel add: testArg2
]

{ #category : #initialization }
PWBBrowsersAbstractTest >> setUp [
	testModel := FamixPWBModel new.
	self initializeTestUserObject.
	self initializeTestFunctions.
	self initializeVariables.
	self initializeAccess.
	self initializeInvocations
]
