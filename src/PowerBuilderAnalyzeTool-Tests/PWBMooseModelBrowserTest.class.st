Class {
	#name : #PWBMooseModelBrowserTest,
	#superclass : #AbstractPWBCallTreeBrowserTest,
	#category : #'PowerBuilderAnalyzeTool-Tests'
}

{ #category : #running }
PWBMooseModelBrowserTest >> setUp [
	super setUp.
	browser := PWBMooseModelBrowser new.
	browser model
		pwbMooseModel: (testModel allWithType: FamixPWBUserObject)
]

{ #category : #tests }
PWBMooseModelBrowserTest >> testBrowserDefaultModeIsFreeze [
	self assert: browser isFreeze
]

{ #category : #tests }
PWBMooseModelBrowserTest >> testPWBModelIsNotNil [
	self assert: PWBMooseModelBrowser new model pwbMooseModel isNotNil
]

{ #category : #tests }
PWBMooseModelBrowserTest >> testSelectedISNotNilWhenAnItemIsSelectedInTheTree [
	browser setModelPresenterSelection.
	self assert: browser selected isNotNil
]

{ #category : #tests }
PWBMooseModelBrowserTest >> testSelectedItemIsNotNil [
	browser setModelPresenterSelection.
	self assert: browser modelPresenter selection selectedItem isNotNil
]

{ #category : #tests }
PWBMooseModelBrowserTest >> testSetBrowserStat [
	browser toFollow.
	self assert: browser isFollow
]

{ #category : #'as yet unclassified' }
PWBMooseModelBrowserTest >> testWhenItemIsGloballySelectedApplicationLogsIsnotEmpty [
	browser setModelPresenterSelection.
	self assert: PWBApplication current logger logs isNotEmpty
]
