Class {
	#name : #PWBAbstractRules,
	#superclass : #Object,
	#instVars : [
		'content'
	],
	#category : #'PowerBuilderAnalyzeTool-PWBCriticsBrowser'
}

{ #category : #'instance creation' }
PWBAbstractRules class >> checkRule: aPWBCriticsResult [
	^ self new checkRule: aPWBCriticsResult
]

{ #category : #'instance creation' }
PWBAbstractRules class >> runRules: aPWBCriticsResult [
	self
		subclassesDo: [ :ruleClass | ruleClass checkRule: aPWBCriticsResult ]
]

{ #category : #adding }
PWBAbstractRules >> addContent: anObject [
	content add: anObject
]

{ #category : #'instance creation' }
PWBAbstractRules >> checkRule: aPWBCriticsResult [
	| passed |
	passed := self class new.
	(self modelFrom: aPWBCriticsResult)
		do: [ :var | 
			(self verify: var)
				ifTrue: [ passed addContent: var ]
				ifFalse: [ content add: var ] ].
	self ifNotEmpty: [ aPWBCriticsResult addRuleViolated: self ].
	passed ifNotEmpty: [ aPWBCriticsResult addRulePassed: passed ]
]

{ #category : #adding }
PWBAbstractRules >> content [
	^ content
]

{ #category : #testing }
PWBAbstractRules >> ifNotEmpty: aBlock [
	self content isEmpty
		ifTrue: [ self ]
		ifFalse: [ aBlock cull: self ]
]

{ #category : #initialization }
PWBAbstractRules >> initialize [
	super initialize.
	content := OrderedCollection new
]

{ #category : #'instance creation' }
PWBAbstractRules >> modelFrom: aPWBCriticsResult [
	^ self subclassResponsibility
]

{ #category : #accessing }
PWBAbstractRules >> ruleName [
	^ self className copyReplaceAll: 'Rule' with: ''
]

{ #category : #'instance creation' }
PWBAbstractRules >> verify: anObject [
	^ self subclassResponsibility
]

{ #category : #'error-message' }
PWBAbstractRules >> violationMessage [
	 self subclassResponsibility
]
