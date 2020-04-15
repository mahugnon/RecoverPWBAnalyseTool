Class {
	#name : #PWBMooseModelBrowserModel,
	#superclass : #PWBAbstractModel,
	#category : #'PowerBuilderAnalyzeTool-Models'
}

{ #category : #initialization }
PWBMooseModelBrowserModel >> initialize [
	| liq_cal |
	super initialize.
	liq_cal := (MooseModel root first allWithType: FamixPWBUserObject)
		detect: [ :each | each name = 'uo_traitement_liq_cal' ].
		pwbMooseModel := liq_cal allIncomingInvocationsSenders

]

{ #category : #accessing }
PWBMooseModelBrowserModel >> selected: anEntity [
	selected := anEntity
]
