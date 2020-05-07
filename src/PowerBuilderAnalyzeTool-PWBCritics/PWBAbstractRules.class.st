Class {
	#name : #PWBAbstractRules,
	#superclass : #Object,
	#category : #'PowerBuilderAnalyzeTool-PWBCritics'
}

{ #category : #'instance creation' }
PWBAbstractRules class >> runRule: aPWBCriticsResult [
	self
		subclassesDo: [ :ruleClass | ruleClass runOn: aPWBCriticsResult ]
]

{ #category : #'error-message' }
PWBAbstractRules >> violationMessage [
	^ self subclassResponsibility
]
