Class {
	#name : #QuerySameNameFunctions,
	#superclass : #AbstractPWBQuery,
	#category : #'PowerBuilderAnalyzeTool-Query'
}

{ #category : #running }
QuerySameNameFunctions >> runOn: aMooseModel [
	| group |
	group := (aMooseModel allModelMethods
		select: [ :m | m parentType isNotNil ]) groupedBy: #name.
	^ group
		keysAndValuesDo: [ :key :value | 
			value size = 1
				ifTrue: [ group removeKey: key ] ]
]
