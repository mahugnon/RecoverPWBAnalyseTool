Extension { #name : #RTView }

{ #category : #'*PowerBuilderAnalyzeTool' }
RTView >> nestedElements [
	^ elements flatCollectAsSet: #nestedElements
]
