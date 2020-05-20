Class {
	#name : #PWBDuplicationBrowserTests,
	#superclass : #PWBBrowsersAbstractTest,
	#category : #'PowerBuilderAnalyzeTool-Tests'
}

{ #category : #initialization }
PWBDuplicationBrowserTests >> setUp [
	super setUp.
	browser := PWBDuplicationBrowser new
]

{ #category : #initialization }
PWBDuplicationBrowserTests >> testCurrentStateChangeWhenRadionButtonIsActivated [
	browser toFreeze .
	self assert: browser isFreeze
]

{ #category : #initialization }
PWBDuplicationBrowserTests >> testCurrentStateIsFollowWhenLunch [
	self assert: browser isFollow
]

{ #category : #initialization }
PWBDuplicationBrowserTests >> testMinNumberOfCharactersChange [
	browser minNumberOfCharactersInput text: 5.
	self assert: browser minNumberOfCharacters equals: 5
]

{ #category : #initialization }
PWBDuplicationBrowserTests >> testMinimumParamNumberOfLineChange [
	browser minNumberOfLinesTextInput text: 5.
	self assert: browser minNumberOfLines equals: 5
]

{ #category : #tests }
PWBDuplicationBrowserTests >> testSelectTheRightDetectorStrategy [
	| param |
	param := PowerbuliderDuplicationParam new.
	param backEndClass: DPDetector.
	self
		assert: (DuplicationStrategy chooseBackEndFor: param)
		equals: DuplicationWithDPDetectorStrategy
]
