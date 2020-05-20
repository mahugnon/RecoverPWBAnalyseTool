Class {
	#name : #QueryDuplicationWithFamixRepDetector,
	#superclass : #QueryDuplication,
	#category : #'PowerBuilderAnalyzeTool-Query'
}

{ #category : #visiting }
QueryDuplicationWithFamixRepDetector class >> backEndClass [
	^ FamixRepDetector
]

{ #category : #running }
QueryDuplicationWithFamixRepDetector >> createBackEndFrom: aPWBDuplicationParameter [
	^ FamixRepConfiguration new
		minimumNumberOfLines: aPWBDuplicationParameter minNumberOfLines;
		minimumNumberOfReplicas: 2;
		minimumNumberOfCharacters: aPWBDuplicationParameter minNumberOfCharacters;
		sourcesCleaner: FamixRepCPPCleaner new
]

{ #category : #running }
QueryDuplicationWithFamixRepDetector >> fragmentFrom: aPWBDuplicationParameter [
	^ (self executeBackEndOn: aPWBDuplicationParameter)
		replicatedFragments
]
