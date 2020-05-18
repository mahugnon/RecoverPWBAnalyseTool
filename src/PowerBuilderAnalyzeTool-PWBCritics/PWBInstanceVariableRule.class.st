Class {
	#name : #PWBInstanceVariableRule,
	#superclass : #PWBVariableRules,
	#category : #'PowerBuilderAnalyzeTool-PWBCritics'
}

{ #category : #'instance creation' }
PWBInstanceVariableRule >> modelFrom: aPWBCriticsResult [
	^ aPWBCriticsResult model allWithType: FamixPWBInstanceVariable
]

{ #category : #'instance creation' }
PWBInstanceVariableRule >> verify: aFamixPWBInstanceVariable [
	^aFamixPWBInstanceVariable name beginsWith: 'i'
]

{ #category : #'error-message' }
PWBInstanceVariableRule >> violationMessage [
	^ 'Powerbuilder instance variable name  should start with the letter i'
]
