Class {
	#name : #PWBLocalVariableRule,
	#superclass : #PWBVariableRules,
	#category : #'PowerBuilderAnalyzeTool-PWBCritics'
}

{ #category : #'instance creation' }
PWBLocalVariableRule >> modelFrom: aPWBCriticsResult [
	^ aPWBCriticsResult model allWithType: FamixPWBLocalVariable
]

{ #category : #'instance creation' }
PWBLocalVariableRule >> verify: aFamixPWBLocalVariable [
	^ aFamixPWBLocalVariable name beginsWith: 'l'
]

{ #category : #'error-message' }
PWBLocalVariableRule >> violationMessage [
	^ 'Powerbuilder local variable name  should start with the letter l'
]
