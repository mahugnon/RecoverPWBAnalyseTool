Extension { #name : #FamixPWBBehavioral }

{ #category : #'*PowerBuilderAnalyzeTool' }
FamixPWBBehavioral >> addDeadArgumentVar: aFamixPWBVariable [
	self deadArguments add: aFamixPWBVariable
]

{ #category : #'*PowerBuilderAnalyzeTool' }
FamixPWBBehavioral >> addDeadLocalVar: aFamixPWBVariable [
	self deadLocalVariables add: aFamixPWBVariable
]

{ #category : #'*PowerBuilderAnalyzeTool' }
FamixPWBBehavioral >> deadArguments [
	deadArguments ifNil: [ deadArguments := OrderedCollection new ].
	^ deadArguments
]

{ #category : #'*PowerBuilderAnalyzeTool' }
FamixPWBBehavioral >> deadLocalVariables [
	deadLocalVariables
		ifNil: [ deadLocalVariables := OrderedCollection new ].
	^ deadLocalVariables
]
