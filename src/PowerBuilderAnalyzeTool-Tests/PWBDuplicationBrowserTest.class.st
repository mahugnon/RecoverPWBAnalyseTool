Class {
	#name : #PWBDuplicationBrowserTest,
	#superclass : #AbstractPWBCallTreeBrowserTest,
	#category : #'PowerBuilderAnalyzeTool-Tests'
}

{ #category : #running }
PWBDuplicationBrowserTest >> setUp [
	super setUp.
	browser := PWBDuplicationBrowser new
]

{ #category : #tests }
PWBDuplicationBrowserTest >> testCurrentStateChangeWhenRadionButtonIsActivated [
	browser toFreeze .
	self assert: browser isFreeze
]

{ #category : #tests }
PWBDuplicationBrowserTest >> testCurrentStateIsFollowWhenLunch [
	self assert: browser isFollow
]

{ #category : #tests }
PWBDuplicationBrowserTest >> testMinNumberOfCharactersChange [
	browser minNumberOfCharactersInput text: 5.
	self assert: browser minNumberOfCharacters equals: 5
]

{ #category : #tests }
PWBDuplicationBrowserTest >> testMinimumParamNumberOfLineChange [
	browser minNumberOfLinesTextInput text: 5.
	self assert: browser minNumberOfLines equals: 5
]
