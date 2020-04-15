Class {
	#name : #OptionParameters,
	#superclass : #Object,
	#instVars : [
		'action',
		'maxLevel',
		'selectedEntities',
		'typeToFilter'
	],
	#category : #'PowerBuilderAnalyzeTool-Models'
}

{ #category : #accessing }
OptionParameters >> action [
	^ action
]

{ #category : #accessing }
OptionParameters >> action: aString [
	action := aString
]

{ #category : #accesing }
OptionParameters >> addEntity: aFamixPWBUserObject [
	(selectedEntities includes: aFamixPWBUserObject)
		ifFalse: [ selectedEntities add: aFamixPWBUserObject ]
]

{ #category : #accesing }
OptionParameters >> addTypeToFilter: aFamixPWBUserObject [
	(typeToFilter includes: aFamixPWBUserObject)
		ifFalse: [ typeToFilter add: aFamixPWBUserObject ]
]

{ #category : #initialization }
OptionParameters >> initialize [
	selectedEntities := OrderedCollection new.
	typeToFilter := OrderedCollection new.
	maxLevel := 1
]

{ #category : #accessing }
OptionParameters >> maxLevel [
	^ maxLevel
]

{ #category : #'accessing ' }
OptionParameters >> maxLevel: anInteger [
	maxLevel := anInteger
]

{ #category : #'add-remove' }
OptionParameters >> removeEntities: anObject [
	selectedEntities remove: anObject
]

{ #category : #'add-remove' }
OptionParameters >> removeTypeToFilters: anObject [
	typeToFilter remove: anObject
]

{ #category : #accessing }
OptionParameters >> selectedEntities [
	^ selectedEntities
]

{ #category : #accessing }
OptionParameters >> typeToFilter [
	^ typeToFilter
]

{ #category : #accessing }
OptionParameters >> typeToFilter: anObject [
	typeToFilter := anObject
]

{ #category : #accessing }
OptionParameters >> typeTofilter [
	^ typeToFilter
]
