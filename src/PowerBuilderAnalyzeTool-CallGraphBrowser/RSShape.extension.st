Extension { #name : #RSShape }

{ #category : #'*PowerBuilderAnalyzeTool-CallGraphBrowser' }
RSShape >> addActionsTag [
	PWBTagForm tag: self
]

{ #category : #'*PowerBuilderAnalyzeTool-CallGraphBrowser' }
RSShape >> removeActionsTag [
	(self model mooseModel findTagCategoryNamed: #Actions) markedTags
		do: [ :aTag | self model removeTag: aTag ]
]
