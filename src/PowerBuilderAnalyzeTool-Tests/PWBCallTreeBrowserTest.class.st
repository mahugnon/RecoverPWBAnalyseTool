Class {
	#name : #PWBCallTreeBrowserTest,
	#superclass : #AbstractPWBCallTreeBrowserTest,
	#instVars : [
		'browserModel'
	],
	#category : #'PowerBuilderAnalyzeTool-Tests'
}

{ #category : #running }
PWBCallTreeBrowserTest >> setUp [
	super setUp.
	browser := PWBCallTreeBrowser new.
browserModel := browser model
]

{ #category : #'as yet unclassified' }
PWBCallTreeBrowserTest >> testApplicationLogsIsEmpty [
	PWBApplication reset.
	self deny: PWBApplication current logger logs isNotEmpty
]

{ #category : #tests }
PWBCallTreeBrowserTest >> testBrowserModelIsNotNil [
	self assert: browser model isNotNil
]

{ #category : #tests }
PWBCallTreeBrowserTest >> testBrowserStatedMustRemainTheSameIffreeze [
	browser toFreeze.
	browser selectEntity: testUserObject1.
	self deny: browser model selected equals: testUserObject1
]

{ #category : #tests }
PWBCallTreeBrowserTest >> testInitializationOptionPanel [
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

{ #category : #tests }
PWBCallTreeBrowserTest >> testQueryIncomingInvocationsSendersAtLevel [
	self
		assertCollection:
			(testUserObject1
				incomingInvocationsSenders: 2
				expectFromMethodsOfType: #())
		hasSameElements:
			{testUserObject2.
			testUserObject3}
]
