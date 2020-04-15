Class {
	#name : #DPEntitiesTest,
	#superclass : #TestCase,
	#category : #'Duplication-Entities-Tests'
}

{ #category : #tests }
DPEntitiesTest >> testClonedFragment [
	| fragment |
	fragment := DPClonedFragment new
		cloneName: 'test';
		yourself.
	fragment cloneName: 'fragment'.
	self assert: fragment cloneName = 'fragment'
]

{ #category : #tests }
DPEntitiesTest >> testDuplicationSys [
	| fragment program location model |
	program := FAMIXContainerEntity new name: 'myProgram'.
	model := MooseModel new.
	model add: program.
	model dupSys: DPDuplicationSystem new.
	fragment := DPClonedFragment new
		cloneName: 'test';
		yourself.
	location := DPFragmentLocation new
		startLine: 1;
		endLine: 12;
		entity: program.
	program addCloneLocation: location.
	fragment addMember: location.
	self assert: location clonedFragment = fragment.
	self assert: fragment members size equals: 1.
	self assert: fragment locationsOfCloneClass size equals: 1.
	self assert: model allContainersWithDuplicatedCode size equals: 1.
	program clearDuplicationCache.
	self assert: model allContainersWithDuplicatedCode isEmpty
]

{ #category : #tests }
DPEntitiesTest >> testProgramCache [
	| program location |
	program := FAMIXBehaviouralEntity new.
	location := DPFragmentLocation new
		startLine: 1;
		endLine: 10;
		entity: program;
		yourself.
	program addCloneLocation: location.
	self assert: program containsClone.
	program clearDuplicationCache.
	self deny: program containsClone
]
