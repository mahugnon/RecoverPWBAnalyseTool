Class {
	#name : #DPClonedFragmentTest,
	#superclass : #TestCase,
	#category : #'Duplication-Entities-Tests'
}

{ #category : #tests }
DPClonedFragmentTest >> testFragmentNotMergeableWithItself [
	|frag1 entity1 |
	entity1 := FAMIXBehaviouralEntity new.
	
	frag1 := DPClonedFragment new members: { (DPFragmentLocation from: 5 to: 8 for: entity1) . (DPFragmentLocation from: 21 to: 24 for: entity1) }.
	
	self deny: (frag1 mergeableWith: frag1)
]

{ #category : #tests }
DPClonedFragmentTest >> testMerge [
	| anchor frag1 frag2 entity1 entity2 dupSys |
	entity1 := FAMIXBehaviouralEntity new.
	entity2 := FAMIXBehaviouralEntity new.
	anchor := FAMIXFileAnchor new.
	frag1 := DPClonedFragment new
		addMember: (DPFragmentLocation from: 5 to: 8 for: entity1);
		addMember: (DPFragmentLocation from: 21 to: 24 for: entity2).
	frag2 := DPClonedFragment new
		addMember: (DPFragmentLocation from: 9 to: 15 for: entity1);
		addMember: (DPFragmentLocation from: 25 to: 31 for: entity2).
	frag1 members , frag2 members
		do: [ :location | location fileAnchor: anchor ].
	dupSys := DPDuplicationSystem new
		fragments:
			{frag1.
			frag2} asSet.
	self assert: entity1 cloneLocations size equals: 2.
	self assert: entity2 cloneLocations size equals: 2.
	frag1 mergeWith: frag2 dupSys: dupSys.
	self assert: entity1 cloneLocations size equals: 1.
	self assert: entity2 cloneLocations size equals: 1.
	self assert: entity1 cloneLocations first startLine equals: 5.
	self assert: entity1 cloneLocations first endLine equals: 15.
	self assert: entity2 cloneLocations first startLine equals: 21.
	self assert: entity2 cloneLocations first endLine equals: 31.
	self assert: entity1 cloneLocations size equals: 1.
	self assert: entity2 cloneLocations size equals: 1
]

{ #category : #tests }
DPClonedFragmentTest >> testMergeable [
	|frag1 frag2 entity1 entity2|
	entity1 := FAMIXBehaviouralEntity new.
	entity2 := FAMIXBehaviouralEntity new.
	
	frag1 := DPClonedFragment new members: { (DPFragmentLocation from: 5 to: 8 for: entity1) . (DPFragmentLocation from: 21 to: 24 for: entity2) }.
	frag2 := DPClonedFragment new members: { (DPFragmentLocation from: 9 to: 15 for: entity1) . (DPFragmentLocation from: 25 to: 31 for: entity2) }.
	
	self assert: (frag1 mergeableWith: frag2)
]

{ #category : #tests }
DPClonedFragmentTest >> testMergeableOverlap [
	|frag1 frag2 entity1 entity2|
	entity1 := FAMIXBehaviouralEntity new.
	entity2 := FAMIXBehaviouralEntity new.
	
	frag1 := DPClonedFragment new members: { (DPFragmentLocation from: 5 to: 8 for: entity1) . (DPFragmentLocation from: 21 to: 24 for: entity2) }.
	frag2 := DPClonedFragment new members: { (DPFragmentLocation from: 6 to: 9 for: entity1) . (DPFragmentLocation from: 22 to: 25 for: entity2) }.
	
	self assert: (frag1 mergeableWith: frag2)
]

{ #category : #tests }
DPClonedFragmentTest >> testNotMergeable [
	|frag1 frag2 entity1 entity2|
	entity1 := FAMIXBehaviouralEntity new.
	entity2 := FAMIXBehaviouralEntity new.
	
	frag1 := DPClonedFragment new members: { (DPFragmentLocation from: 5 to: 8 for: entity2) . (DPFragmentLocation from: 21 to: 24 for: entity1) }.
	frag2 := DPClonedFragment new members: { (DPFragmentLocation from: 9 to: 15 for: entity1) . (DPFragmentLocation from: 25 to: 31 for: entity2) }.
	
	self assert: (frag1 mergeableWith: frag2) equals: false
]
