Class {
	#name : #DuplicationWithDPDetectorStrategy,
	#superclass : #DuplicationStrategy,
	#category : #'PowerBuilderAnalyzeTool-DuplicationGUI-Core'
}

{ #category : #visiting }
DuplicationWithDPDetectorStrategy class >> backEndClass [
	^ DPDetector
]

{ #category : #running }
DuplicationWithDPDetectorStrategy >> createBackEndParameter [
	^ DPParameters new
		minNumberOfLines: pWBDuplicationParameter minimumNumberOfLines;
		frequency: 2;
		minNumberOfCharacters: pWBDuplicationParameter minimumNumberOfCharacters;
		cleaner: DPPWBCleaner new
]

{ #category : #running }
DuplicationWithDPDetectorStrategy >> fragmentsFromBackEnd [
	^ (self backEnd
		parameters: self createBackEndParameter;
		runOn: pWBDuplicationParameter entities) fragments
]
