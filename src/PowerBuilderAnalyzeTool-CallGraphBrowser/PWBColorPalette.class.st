Class {
	#name : #PWBColorPalette,
	#superclass : #RSColorPaletteChooser,
	#instVars : [
		'selectedColor'
	],
	#category : #'PowerBuilderAnalyzeTool-CallGraphBrowser-TagForm'
}

{ #category : #'clipboard handling' }
PWBColorPalette >> copyToClipboard: anObject [
	anObject isColor
		ifFalse: [ ^ self ].
	selectedColor := anObject.
	self inform: ' Color selected !!!'
]

{ #category : #initialization }
PWBColorPalette >> initializeWindow: w [
	w
		title: 'Color Palettes';
		centered
]

{ #category : #accessing }
PWBColorPalette >> selectedColor [
	^ selectedColor
]
