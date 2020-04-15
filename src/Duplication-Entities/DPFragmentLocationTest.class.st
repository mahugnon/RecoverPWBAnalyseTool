Class {
	#name : #DPFragmentLocationTest,
	#superclass : #TestCase,
	#category : #'Duplication-Entities-Tests'
}

{ #category : #tests }
DPFragmentLocationTest >> testContiguousApreviousB [
	|a b entity|
	entity := FAMIXBehaviouralEntity new.
	a := DPFragmentLocation from: 2 to: 4 for: entity.
	b := DPFragmentLocation from: 5 to: 8 for: entity.
	self assert: (a contiguousWith: b) equals: true
]

{ #category : #tests }
DPFragmentLocationTest >> testContiguousApreviousBdifferentsEntities [
	|a b entity1 entity2|
	entity1 := FAMIXBehaviouralEntity new.
	entity2 := FAMIXBehaviouralEntity new.
	a := DPFragmentLocation from: 2 to: 4 for: entity1.
	b := DPFragmentLocation from: 5 to: 8 for: entity2.
	self assert: (a contiguousWith: b) equals: false
]

{ #category : #tests }
DPFragmentLocationTest >> testContiguousApreviousBwithUnion [
	|a b entity|
	entity := FAMIXBehaviouralEntity new.
	a := DPFragmentLocation from: 2 to: 4 for: entity.
	b := DPFragmentLocation from: 4 to: 8 for: entity.
	self assert: (a contiguousWith: b) equals: true
]

{ #category : #tests }
DPFragmentLocationTest >> testContiguousBpreviousA [
	|a b entity|
	entity := FAMIXBehaviouralEntity new.
	b := DPFragmentLocation from: 2 to: 4 for: entity.
	a := DPFragmentLocation from: 5 to: 8 for: entity.
	self assert: (a contiguousWith: b) equals: true
]

{ #category : #tests }
DPFragmentLocationTest >> testContiguousBpreviousAwithUnion [
	|a b entity|
	entity := FAMIXBehaviouralEntity new.
	b := DPFragmentLocation from: 2 to: 4 for: entity.
	a := DPFragmentLocation from: 4 to: 8 for: entity.
	self assert: (a contiguousWith: b) equals: true
]

{ #category : #tests }
DPFragmentLocationTest >> testContiguousDifferentLength [
	|a b entity|
	"For the moment, we do not consider the cases where the lengths of the merging fragments is different. Added this test to understand the behavior in case of different lengths"
	entity := FAMIXBehaviouralEntity new.
	a := DPFragmentLocation from: 2 to: 4 for: entity.
	b := DPFragmentLocation from: 1 to: 10 for: entity.
	self assert: (a contiguousWith: b) equals: true
]

{ #category : #tests }
DPFragmentLocationTest >> testNotContiguousApreviousB [
	|a b entity|
	entity := FAMIXBehaviouralEntity new.
	a := DPFragmentLocation from: 2 to: 4 for: entity.
	b := DPFragmentLocation from: 6 to: 8 for: entity.
	self assert: (a contiguousWith: b) equals: false
]

{ #category : #tests }
DPFragmentLocationTest >> testNotContiguousBpreviousA [
	|a b entity|
	entity := FAMIXBehaviouralEntity new.
	b := DPFragmentLocation from: 2 to: 4 for: entity.
	a := DPFragmentLocation from: 6 to: 8 for: entity.
	self assert: (a contiguousWith: b) equals: false
]
