Class {
	#name : #DuplicationWithFamixRepDetectorStrategy,
	#superclass : #DuplicationStrategy,
	#category : #'PowerBuilderAnalyzeTool-DuplicationGUI-Core'
}

{ #category : #visiting }
DuplicationWithFamixRepDetectorStrategy class >> backEndClass [
	^ FamixRepDetector
]

{ #category : #running }
DuplicationWithFamixRepDetectorStrategy >> createBackEndParameter [
	^ FamixRepConfiguration new
		minimumNumberOfLines: pWBDuplicationParameter minimumNumberOfLines;
		minimumNumberOfReplicas: 2;
		minimumNumberOfCharacters: pWBDuplicationParameter minimumNumberOfCharacters;
		sourcesCleaner: FamixRepCPPCleaner new
]

{ #category : #running }
DuplicationWithFamixRepDetectorStrategy >> fragmentsFromBackEnd [
	^ (self backEnd
		configuration: self createBackEndParameter;
		runOn: pWBDuplicationParameter entities) replicatedFragments
]
