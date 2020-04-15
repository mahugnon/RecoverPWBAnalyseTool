Extension { #name : #FamixPWBVariable }

{ #category : #'*PowerBuilderAnalyzeTool' }
FamixPWBVariable >> behavioralForIfDead [
	self isLocal
		ifTrue: [ self behavioral addDeadLocalVar: self ]
		ifFalse: [ self behavioral addDeadArgumentVar: self ].
	^ self behavioral
]

{ #category : #'*PowerBuilderAnalyzeTool' }
FamixPWBVariable >> isArgument [
	^ self name matchesRegex: 'a.*'
]

{ #category : #'*PowerBuilderAnalyzeTool' }
FamixPWBVariable >> isLocal [
	^ name matchesRegex: 'l.*'
]
