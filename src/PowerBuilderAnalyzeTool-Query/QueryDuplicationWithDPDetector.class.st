Class {
	#name : #QueryDuplicationWithDPDetector,
	#superclass : #QueryDuplication,
	#category : #'PowerBuilderAnalyzeTool-Query'
}

{ #category : #visiting }
QueryDuplicationWithDPDetector class >> backEndClass [
	^ DPDetector
]

{ #category : #running }
QueryDuplicationWithDPDetector >> createBackEndParameter [
	^ DPParameters new
		minNumberOfLines: pWBDuplicationParameter minNumberOfLines;
		frequency: 2;
		minNumberOfCharacters: pWBDuplicationParameter minNumberOfCharacters;
		cleaner: DPPWBCleaner new
]

{ #category : #running }
QueryDuplicationWithDPDetector >> fragmentsFromBackEnd [
	^ (self backEnd
		parameters: self createBackEndParameter;
		runOn: pWBDuplicationParameter entities) fragments
]
