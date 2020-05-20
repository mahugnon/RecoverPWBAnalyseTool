Class {
	#name : #PWBSharedVariableRule,
	#superclass : #PWBVariableRules,
	#category : #'PowerBuilderAnalyzeTool-PWBCritics'
}

{ #category : #'instance creation' }
PWBSharedVariableRule >> modelFrom: aPWBCriticsResult [
	^ aPWBCriticsResult model allWithType: FamixPWBSharedVariable
]

{ #category : #'instance creation' }
PWBSharedVariableRule >> verify: aFamixPWBSharedVariable [
	^ aFamixPWBSharedVariable name beginsWith: 's'
]

{ #category : #'error-message' }
PWBSharedVariableRule >> violationMessage [
	^ 'Powerbuilder local variable name  should start with the letter s'
]
