Extension { #name : #RSShape }

{ #category : #'*PowerBuilderAnalyzeTool-CallGraphBrowser' }
RSShape >> addTag [
	PWBTagForm tag: self
]

{ #category : #'*PowerBuilderAnalyzeTool-CallGraphBrowser' }
RSShape >> markAs: aString [
	self model addTag: (self model tagNamed: aString).
	^ self color: (ColorObject colorFor: self model)
]

{ #category : #'*PowerBuilderAnalyzeTool-CallGraphBrowser' }
RSShape >> unMark [
	self model allTags do: [ :tag | self model removeTag: tag ].
	self color: (ColorObject colorFor: self model)
]
