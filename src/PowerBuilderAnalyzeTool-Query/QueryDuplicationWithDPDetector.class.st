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
QueryDuplicationWithDPDetector >> createBackEndFrom: aPWBDuplicationParameter [
	^ DPParameters new
		minNumberOfLines: aPWBDuplicationParameter minNumberOfLines;
		frequency: 2;
		minNumberOfCharacters: aPWBDuplicationParameter minNumberOfCharacters;
		cleaner: DPPWBCleaner new
]

{ #category : #running }
QueryDuplicationWithDPDetector >> fragmentFrom: aPWBDuplicationParameter [
	^ (self executeBackEndOn: aPWBDuplicationParameter) fragments
]
