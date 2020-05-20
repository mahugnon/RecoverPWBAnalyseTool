Class {
	#name : #QueryDuplication1,
	#superclass : #QueryDuplication,
	#category : #'PowerBuilderAnalyzeTool-Query'
}

{ #category : #running }
QueryDuplication1 >> runOn: aCollection with: aFamixReplicaConfiguration [
	^ (PowerbuliderDuplicationSystem
		withAll:
		(FamixRepDetector new
		configuration: aFamixReplicaConfiguration;
		runOn: aCollection asOrderedCollection) replicatedFragments)
		setColors;
		fragments
]
