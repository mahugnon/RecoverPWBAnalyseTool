Extension { #name : #SpLabelledPresenter }

{ #category : #'*PowerBuilderAnalyzeTool-Tests' }
SpLabelledPresenter >> text: aText [
	input text: aText
]

{ #category : #'*PowerBuilderAnalyzeTool' }
SpLabelledPresenter >> whenTextChangedDo: aBlock [
	^ input whenTextChangedDo: aBlock
]
