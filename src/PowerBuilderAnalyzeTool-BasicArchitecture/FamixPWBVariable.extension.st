Extension { #name : #FamixPWBVariable }

{ #category : #'*PowerBuilderAnalyzeTool-BasicArchitecture' }
FamixPWBVariable >> behavioralForIfDead [
	self isLocal
		ifTrue: [ self behavioral addDeadLocalVar: self ]
		ifFalse: [ self behavioral addDeadArgumentVar: self ].
	^ self behavioral
]

{ #category : #'*PowerBuilderAnalyzeTool-BasicArchitecture' }
FamixPWBVariable >> isArgument [
	^ self name matchesRegex: 'a.*'
]

{ #category : #'*PowerBuilderAnalyzeTool-BasicArchitecture' }
FamixPWBVariable >> isLocal [
	^ name matchesRegex: 'l.*'
]
