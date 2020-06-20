Class {
	#name : #PWBMooseModelBrowserModel,
	#superclass : #PWBAbstractModel,
	#instVars : [
		'contextMenuResult'
	],
	#category : #'PowerBuilderAnalyzeTool-ModelBrowser-Model'
}

{ #category : #initialization }
PWBMooseModelBrowserModel >> initialize [
	super initialize.
	pwbMooseModel := #()
]

{ #category : #accessing }
PWBMooseModelBrowserModel >> selected: anEntity [
	selected := anEntity
]

{ #category : #initialization }
PWBMooseModelBrowserModel >> setUp [
	| liq_cal |
	pwbMooseModel ifNotEmpty: [ ^ self ].
	liq_cal := (MooseModel root first allWithType: FamixPWBUserObject)
		detect: [ :each | each name = 'uo_traitement_liq_cal' ].
	pwbMooseModel := liq_cal allIncomingInvocationsSenders
		asOrderedCollection
]
