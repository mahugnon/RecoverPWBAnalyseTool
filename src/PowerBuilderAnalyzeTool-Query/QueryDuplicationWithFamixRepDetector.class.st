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
QueryDuplicationWithFamixRepDetector >> createBackEndParameter [
	^ FamixRepConfiguration new
		minimumNumberOfLines: pWBDuplicationParameter minimumNumberOfLines;
		minimumNumberOfReplicas: 2;
		minimumNumberOfCharacters: pWBDuplicationParameter minimumNumberOfCharacters;
		sourcesCleaner: FamixRepCPPCleaner new
]

{ #category : #running }
QueryDuplicationWithFamixRepDetector >> fragmentsFromBackEnd [
	^ (self backEnd
		configuration: self createBackEndParameter;
		runOn: pWBDuplicationParameter entities) replicatedFragments
]
