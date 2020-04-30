Class {
	#name : #PWBMooseModelBrowserTests,
	#superclass : #PWBBrowsersAbstractTest,
	#category : #'PowerBuilderAnalyzeTool-Tests'
}

{ #category : #initialization }
PWBMooseModelBrowserTests >> setUp [
	super setUp.
	browser := PWBMooseModelBrowser new.
	browser model
		pwbMooseModel: (testModel allWithType: FamixPWBUserObject).
	browser setUp
]

{ #category : #initialization }
PWBMooseModelBrowserTests >> testBrowserDefaultModeIsFreeze [
	self assert: browser isFreeze
]

{ #category : #initialization }
PWBMooseModelBrowserTests >> testPWBModelIsNotNil [
	self assert: PWBMooseModelBrowser new model pwbMooseModel isNotNil
]

{ #category : #initialization }
PWBMooseModelBrowserTests >> testSelectedISNotNilWhenAnItemIsSelectedInTheTree [
	browser setModelPresenterSelection.
	self assert: browser selected isNotNil
]

{ #category : #initialization }
PWBMooseModelBrowserTests >> testSelectedItemIsNotNil [
	browser setModelPresenterSelection.
	self assert: browser modelPresenter selectedItems isNotEmpty
]

{ #category : #initialization }
PWBMooseModelBrowserTests >> testSetBrowserState [
	browser toFollow.
	self assert: browser isFollow
]
