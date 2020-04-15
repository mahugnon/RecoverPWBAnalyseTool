Extension { #name : #RSShape }

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
RSShape >> addTag [
	| tagForm |
	tagForm := PWBTagForm tag: self model.
	tagForm window
		okAction: [ tagForm tagsList selectedItem ifNil: [ ^ self ].
			tagForm entity addTag: tagForm tagsList selectedItem.
			self color: (ColorObject colorFor: self model) ]
]

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
RSShape >> markAs: aString [
	self model addTag: (self model tagNamed: aString).
	^ self color: (ColorObject colorFor: self model)
]

{ #category : #'*PowerBuilderAnalyzeTool-CallTree' }
RSShape >> unMark [
	self model allTags do: [ :tag | self model removeTag: tag ].
	self color: (ColorObject colorFor: self model)
]
