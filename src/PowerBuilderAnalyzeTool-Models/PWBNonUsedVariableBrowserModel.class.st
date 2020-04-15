Class {
	#name : #PWBNonUsedVariableBrowserModel,
	#superclass : #PWBAbstractModel,
	#instVars : [
		'instAndVars',
		'insVarLocaVarArgs',
		'functions',
		'variables',
		'nonUsedVariables',
		'nonUsedInstVars',
		'focusVariables'
	],
	#category : #'PowerBuilderAnalyzeTool-Models'
}

{ #category : #accessing }
PWBNonUsedVariableBrowserModel >> focusVariables: anObject [
	focusVariables := {('Local variables'
		-> (anObject deadLocalVariables collectAsSet: #name) asOrderedCollection).
	('Arguments'
		-> (anObject deadArguments collectAsSet: #name) asOrderedCollection)}
		asOrderedDictionary.
	^ focusVariables
]

{ #category : #api }
PWBNonUsedVariableBrowserModel >> focusVariablesFor: aString [
	^ ((focusVariables at: aString) collectAsSet: #name)
		asOrderedCollection
]

{ #category : #utility }
PWBNonUsedVariableBrowserModel >> functionsFor: anObject [
	^ QueryBehavioral runOn: anObject
]

{ #category : #'as yet unclassified' }
PWBNonUsedVariableBrowserModel >> initialize [
	super initialize.
	variables := OrderedCollection new.
	insVarLocaVarArgs := OrderedCollection new.
	functions := OrderedCollection new.
	instAndVars := OrderedCollection new.
	instAndVars
		add: 'Attributs';
		add: 'Variables'
]

{ #category : #accessing }
PWBNonUsedVariableBrowserModel >> insVarLocaVarArgs [
	^ insVarLocaVarArgs
]

{ #category : #accessing }
PWBNonUsedVariableBrowserModel >> instAndVars [
	^ instAndVars
]

{ #category : #utility }
PWBNonUsedVariableBrowserModel >> instOrFunctionFor: aString [
	^ aString = 'Attributs'
		ifTrue: [ nonUsedInstVars ]
		ifFalse: [ QueryBehavioral runOn: nonUsedVariables ]
]

{ #category : #accessing }
PWBNonUsedVariableBrowserModel >> nonUsedVarBehavioral [
	^ QueryBehavioral runOn: nonUsedVariables
]

{ #category : #accessing }
PWBNonUsedVariableBrowserModel >> selected: anObject [
	selected := anObject.
	self updateNonUsedVariable
]

{ #category : #utility }
PWBNonUsedVariableBrowserModel >> updateNonUsedVariable [
	| query |
	query := QueryDeadVariables runOn: selected.
	nonUsedVariables := query variables.
	nonUsedInstVars := query instanceVariables
]

{ #category : #accessing }
PWBNonUsedVariableBrowserModel >> variables [
	^ variables
]
