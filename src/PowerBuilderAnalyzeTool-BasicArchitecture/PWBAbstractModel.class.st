Class {
	#name : #PWBAbstractModel,
	#superclass : #Object,
	#instVars : [
		'selected',
		'pwbMooseModel',
		'pwbBrowser'
	],
	#category : #'PowerBuilderAnalyzeTool-BasicArchitecture-Model'
}

{ #category : #'as yet unclassified' }
PWBAbstractModel >> freezeDuring: aBlock [
	pwbBrowser freezeDuring: aBlock
]

{ #category : #accessing }
PWBAbstractModel >> pwbBrowser: aPWBToRemoveDuplicationListBrowser [ 
	pwbBrowser := aPWBToRemoveDuplicationListBrowser
]

{ #category : #accessing }
PWBAbstractModel >> pwbMooseModel [
	^ pwbMooseModel
]

{ #category : #'accessing ' }
PWBAbstractModel >> pwbMooseModel: anObject [
	pwbMooseModel := anObject
]

{ #category : #accessing }
PWBAbstractModel >> selected [
	^ selected
]
