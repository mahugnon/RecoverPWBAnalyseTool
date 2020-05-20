Class {
	#name : #PWBParameterRule,
	#superclass : #PWBVariableRules,
	#category : #'PowerBuilderAnalyzeTool-PWBCritics'
}

{ #category : #'instance creation' }
PWBParameterRule >> modelFrom: aPWBCriticsResult [
	^ aPWBCriticsResult model allWithType: FamixPWBParameter
]

{ #category : #'instance creation' }
PWBParameterRule >> verify: aFamixPWBParameter [
	^ aFamixPWBParameter name beginsWith: 'a'
]

{ #category : #'error-message' }
PWBParameterRule >> violationMessage [
	^ 'Powerbuilder local variable name  should start with the letter a'
]
