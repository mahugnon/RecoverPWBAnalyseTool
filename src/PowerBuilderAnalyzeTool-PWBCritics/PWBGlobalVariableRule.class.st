Class {
	#name : #PWBGlobalVariableRule,
	#superclass : #PWBVariableRules,
	#category : #'PowerBuilderAnalyzeTool-PWBCritics'
}

{ #category : #'instance creation' }
PWBGlobalVariableRule >> modelFrom: aPWBCriticsResult [
	^ aPWBCriticsResult model allWithType: FamixPWBGlobalVariable
]

{ #category : #'instance creation' }
PWBGlobalVariableRule >> verify: aFamixGlobalVariable [
	^ aFamixGlobalVariable name beginsWith: 'g'
]

{ #category : #'error-message' }
PWBGlobalVariableRule >> violationMessage [
	^'A global variable name should always start with the letter g'
]
