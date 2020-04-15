Class {
	#name : #QueryDuplication,
	#superclass : #AbstractPWBQuery,
	#category : #'PowerBuilderAnalyzeTool-Query'
}

{ #category : #running }
QueryDuplication >> runOn: aCollection [
	^ (DPDetector
		runOn: aCollection
		parametrizedWith:
		(DPParameters new
		minNumberOfLines: 10;
		frequency: 2;
		minNumberOfCharacters: 55;
		cleaner: DPPWBCleaner new))
		setColors;
		fragments
]

{ #category : #running }
QueryDuplication >> runOn: aCollection with: aDPParameters [
	^ (DPDetector runOn: aCollection parametrizedWith: aDPParameters)
		setColors;
		fragments
]
