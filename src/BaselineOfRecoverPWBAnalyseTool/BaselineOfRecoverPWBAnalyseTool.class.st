Class {
	#name : #BaselineOfRecoverPWBAnalyseTool,
	#superclass : #BaselineOf,
	#category : #BaselineOfRecoverPWBAnalyseTool
}

{ #category : #baselines }
BaselineOfRecoverPWBAnalyseTool >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ self baselineOfPowerBuilderParser: spec.
			self baselineOfRoassal3: spec.
			self baselineOfColorsExtensions: spec.
			self baselineOfFamixReplicationWithoutFamix: spec.
			self baselineOfFamixTaggingWithoutFamix: spec.
			spec
				package: 'Duplication';
				package: 'Duplication-Detection';
				package: 'Duplication-Entities';
				package: 'PowerBuilderAnalyzeTool-BasicArchitecture';
				package: 'PowerBuilderAnalyzeTool-Query';
				package: 'PowerBuilderAnalyzeTool-CallGraphBrowser'
					with: [ spec
						requires: #('PowerBuilderParser' 'Roassal3' 'PowerBuilderAnalyzeTool-Utils' 'FamixTaggingWithoutFamix') ];
				package: 'PowerBuilderAnalyzeTool-ModelBrowser'
					with: [ spec
						requires: #('PowerBuilderParser' 'PowerBuilderAnalyzeTool-Utils') ];
				package: 'PowerBuilderAnalyzeTool-SourceCodeBrowser';
				package: 'PowerBuilderAnalyzeTool-Tests';
				package: 'PowerBuilderAnalyzeTool-DuplicationBrowser'
					with: [ spec
						requires:
							#('PowerBuilderParser' 'Roassal3' 'FamixReplicationWithoutFamix' 'PowerBuilderAnalyzeTool-Utils') ];
				package: 'PowerBuilderAnalyzeTool-DeadVariables'
					with: [ spec
						requires: #('PowerBuilderParser' 'PowerBuilderAnalyzeTool-Utils') ];
				package: 'PowerBuilderAnalyzeTool-DeadMethodBrowser'
					with: [ spec requires: #('PowerBuilderParser') ];
				package: 'PowerBuilderAnalyzeTool-Utils';
				package: 'PowerBuilderAnalyzeTool-PWBCriticsBrowser';
				package: 'PowerBuilderAnalyzeTool-LogBrowser';
				package: 'FamixTags';
				package: 'PowerBuilderAnalyzeTool-Launcher'
					with: [ spec
						requires:
							#('PowerBuilderAnalyzeTool-DuplicationBrowser' 'PowerBuilderAnalyzeTool-CallGraphBrowser' 'PowerBuilderAnalyzeTool-Query' 'PowerBuilderAnalyzeTool-ModelBrowser' 'PowerBuilderAnalyzeTool-SourceCodeBrowser' 'PowerBuilderAnalyzeTool-Utils') ] ]
]

{ #category : #baselines }
BaselineOfRecoverPWBAnalyseTool >> baselineOfColorsExtensions: spec [
	spec
		baseline: 'ColorsExtensions'
		with: [ spec
				repository: 'github://pharo-contributions/ColorsExtensions:v1.x.x/src' ]
]

{ #category : #baselines }
BaselineOfRecoverPWBAnalyseTool >> baselineOfFamixReplicationWithoutFamix: spec [
	spec
		baseline: 'FamixReplicationWithoutFamix'
		with: [ spec
				repository: 'github://moosetechnology/FamixReplication:v1.x.x/src' ]
]

{ #category : #baselines }
BaselineOfRecoverPWBAnalyseTool >> baselineOfFamixTaggingWithoutFamix: spec [
	spec
    	baseline: 'FamixTaggingWithoutFamix'
    	with: [ spec repository: 'github://moosetechnology/FamixTagging:v1.x.x/src' ]
]

{ #category : #baselines }
BaselineOfRecoverPWBAnalyseTool >> baselineOfPowerBuilderParser: spec [
	spec
		baseline: 'PowerBuilderParser'
		with: [ spec
				repository: 'github://moosetechnology/PowerBuilderParser:master/src' ]
]

{ #category : #baselines }
BaselineOfRecoverPWBAnalyseTool >> baselineOfRoassal2Spec2: spec [
	spec
		baseline: 'Roassal2Spec2'
		with: [ spec repository: 'github://mahugnon/Roassal2Spec2:master/src' ]
]

{ #category : #baselines }
BaselineOfRecoverPWBAnalyseTool >> baselineOfRoassal3: spec [
	spec
		baseline: 'Roassal3'
		with: [ spec repository: 'github://ObjectProfile/Roassal3' ]
]
