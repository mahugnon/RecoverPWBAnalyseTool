Class {
	#name : #PWBNonUsedVariableBrowserTests,
	#superclass : #PWBBrowsersAbstractTest,
	#category : #'PowerBuilderAnalyzeTool-Tests'
}

{ #category : #accessing }
PWBNonUsedVariableBrowserTests >> model [
	^ browser model
]

{ #category : #accessing }
PWBNonUsedVariableBrowserTests >> setUp [
	super setUp.
	browser := PWBNonUsedVariableBrowser new
		selectEntity: testUserObject1
]

{ #category : #accessing }
PWBNonUsedVariableBrowserTests >> testBrowserShouldNotUpdateOnMooseGroup [
	| group |
	group := {testUserObject1.
	testUserObject2} asMooseGroup.
	browser selectEntity: group.
	self deny: browser selected equals: group
]

{ #category : #accessing }
PWBNonUsedVariableBrowserTests >> testTrasmissionsToInstVarArgs [
	self
		assertCollection: (self model instOrFunctionFor: 'Attributs')
		hasSameElements:
			{testInstVar3.
			testInstVar4}.
	self
		assertCollection: (self model instOrFunctionFor: 'Variables')
		hasSameElements:
			{testFunction2.
			testFunction1}
]

{ #category : #accessing }
PWBNonUsedVariableBrowserTests >> testWhenSelectedEntityInstAndVarListShouldBeUpdated [
	self deny: browser instAndVarList model items isEmpty
]

{ #category : #accessing }
PWBNonUsedVariableBrowserTests >> testWhenSelectionChangedForTheFirstTimeInstAndVarsBecomeADictionnaryWith2Keys [
	self
		assertCollection: self model instAndVars
		hasSameElements: {'Attributs' . 'Variables'}
]
