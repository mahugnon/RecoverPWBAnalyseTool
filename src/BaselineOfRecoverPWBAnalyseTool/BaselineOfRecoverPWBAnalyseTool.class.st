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
			spec
				package: 'Duplication';
				package: 'Duplication-Detection';
				package: 'Duplication-Entities';
				package: 'PowerBuilderAnalyzeTool-DeadMethodBrowser';
				with: [ spec requires: #('PowerBuilderParser') ];
				package: 'PowerBuilderAnalyzeTool-DeadVariables';
				package: 'PowerBuilderAnalyzeTool-SourceCodeBrowser';
				package: 'PowerBuilderAnalyzeTool-BasicArchitecture';
				package: 'PowerBuilderAnalyzeTool-Query';
				with: [ spec requires: #('PowerBuilderParser') ];
				package: 'PowerBuilderAnalyzeTool-DuplicationBrowser'
					with: [ spec requires: #('PowerBuilderParser' 'Roassal3') ];
				package: 'PowerBuilderAnalyzeTool-CallGraphBrowser'
					with: [ spec requires: #('PowerBuilderParser' 'Roassal3') ];
				package: 'PowerBuilderAnalyzeTool-Utils';
				package: 'PowerBuilderAnalyzeTool-PWBCriticsBrowser'
					with: [ spec requires: #('PowerBuilderParser') ];
				package: 'PowerBuilderAnalyzeTool-ModelBrowser'
					with: [ spec requires: #('PowerBuilderParser') ] ]
]

{ #category : #baselines }
BaselineOfRecoverPWBAnalyseTool >> baselineOfColorsExtensions: spec [
	spec
		baseline: 'ColorsExtensions'
		with: [ spec
				repository: 'github://pharo-contributions/ColorsExtensions:v1.x.x/src' ]
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
