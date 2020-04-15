Class {
	#name : #PWBApplication,
	#superclass : #SpApplication,
	#instVars : [
		'logger',
		'mooseModel'
	],
	#classVars : [
		'Current'
	],
	#category : #'PowerBuilderAnalyzeTool-Core'
}

{ #category : #accessing }
PWBApplication class >> current [
	^ Current ifNil: [ Current := self new ]
]

{ #category : #accessing }
PWBApplication class >> reset [
	<script>
	Current := nil
]

{ #category : #documentation }
PWBApplication >> browsers [
	^ self windows collect: #presenter thenSelect: #isPWBBrowser
]

{ #category : #enumerating }
PWBApplication >> globallySelect: anEntity [
	self logger globallySelect: anEntity
]

{ #category : #initialization }
PWBApplication >> initialize [
	super initialize.
	self logger: PWBLogger new
]

{ #category : #accessing }
PWBApplication >> logger [
	^ logger
]

{ #category : #accessing }
PWBApplication >> logger: anObject [
	logger := anObject.
	logger application: self
]

{ #category : #'as yet unclassified' }
PWBApplication >> refreshBrowsersWith: anEntity [
	self browsers do: [ :browser | browser selectEntity: anEntity ]
]

{ #category : #accessing }
PWBApplication >> start [
	PWBAnalyzeToolAppLauncher runMe
]
