Class {
	#name : #PWBSpMillerColumnPresenter,
	#superclass : #SpMillerColumnPresenter,
	#instVars : [
		'activationBlock'
	],
	#category : #'PowerBuilderAnalyzeTool-ModelBrowser'
}

{ #category : #activation }
PWBSpMillerColumnPresenter >> activate [
	activationBlock value: (SpMillerActivation on: 1)
]

{ #category : #activation }
PWBSpMillerColumnPresenter >> whenActivatedDo: aBlock [
	activationBlock := aBlock
]
