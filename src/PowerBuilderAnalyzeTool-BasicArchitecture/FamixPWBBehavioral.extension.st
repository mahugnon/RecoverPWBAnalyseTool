Extension { #name : #FamixPWBBehavioral }

{ #category : #'*PowerBuilderAnalyzeTool-BasicArchitecture' }
FamixPWBBehavioral >> addDeadArgumentVar: aFamixPWBVariable [
	self deadArguments add: aFamixPWBVariable
]

{ #category : #'*PowerBuilderAnalyzeTool-BasicArchitecture' }
FamixPWBBehavioral >> addDeadLocalVar: aFamixPWBVariable [
	self deadLocalVariables add: aFamixPWBVariable
]

{ #category : #'*PowerBuilderAnalyzeTool-BasicArchitecture' }
FamixPWBBehavioral >> deadArguments [
	deadArguments ifNil: [ deadArguments := OrderedCollection new ].
	^ deadArguments
]

{ #category : #'*PowerBuilderAnalyzeTool-BasicArchitecture' }
FamixPWBBehavioral >> deadLocalVariables [
	deadLocalVariables
		ifNil: [ deadLocalVariables := OrderedCollection new ].
	^ deadLocalVariables
]
