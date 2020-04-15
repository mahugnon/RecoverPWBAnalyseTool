Class {
	#name : #PWBCallTreeBrowserTests,
	#superclass : #PWBBrowsersAbstractTest,
	#instVars : [
		'browserModel'
	],
	#category : #'PowerBuilderAnalyzeTool-Tests'
}

{ #category : #initialization }
PWBCallTreeBrowserTests >> setUp [
	super setUp.
	browser := PWBCallTreeBrowser new.
browserModel := browser model
]

{ #category : #initialization }
PWBCallTreeBrowserTests >> testApplicationLogsIsEmpty [
	PWBApplication reset.
	self deny: PWBApplication current logger logs isNotEmpty
]

{ #category : #initialization }
PWBCallTreeBrowserTests >> testBrowserModelIsNotNil [
	self assert: browserModel isNotNil
]

{ #category : #initialization }
PWBCallTreeBrowserTests >> testBrowserStatedMustRemainTheSameIffreeze [
	browser toFreeze.
	browser selectEntity: testUserObject1.
	self deny: browserModel selected equals: testUserObject1
]

{ #category : #initialization }
PWBCallTreeBrowserTests >> testInitializationOptionPanel [
	| panel |
	panel := OptionPanel new.
	browser selected: testUserObject1.
	self assert: panel optionParameters isNotNil.
	self assert: panel paramPresenter equals: panel maxLevel.
	panel options selectItem: InvocationWithEntitiesOption.
	self
		assert: panel paramPresenter
		equals: panel possibleEntitiesPresenter.
	panel options selectItem: FilterConsideredMethodTypeOption.
	panel validate.
	self
		assert: panel optionParameters action
		equals: FilterConsideredMethodTypeOption
]

{ #category : #initialization }
PWBCallTreeBrowserTests >> testQueryIncomingInvocationsSendersAtLevel [
	self
		assertCollection:
			(testUserObject1
				incomingInvocationsSenders: 2
				expectFromMethodsOfType: #())
		hasSameElements:
			{testUserObject2.
			testUserObject3}
]
