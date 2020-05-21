Class {
	#name : #DuplicationBrowserRoassalViewByEntity,
	#superclass : #DuplicationBrowserRoassalView,
	#instVars : [
		'etitiesShapes',
		'cloneShapes'
	],
	#category : #'PowerBuilderAnalyzeTool-DuplicationBrowser-roassal'
}

{ #category : #'as yet unclassified' }
DuplicationBrowserRoassalViewByEntity class >> viewName [
	^ 'View by cloned entities'
]

{ #category : #initialization }
DuplicationBrowserRoassalViewByEntity >> buildCloneShapes: anEntity [
	| cloneBoxs |
	cloneBoxs := (model duplicationEntities at: anEntity)
		collect: [ :clone | 
			| box |
			box := RSBox new
				model: clone;
				color: (model colorFor: clone);
				size: 20;
				yourself.
			box
				when: RSMouseLeftClick
				do: [ :evt | self processCloneClickEvent: evt ] ]
		as: RSGroup.
	RSGridLayout on: cloneBoxs.
	^ cloneBoxs
]

{ #category : #initialization }
DuplicationBrowserRoassalViewByEntity >> buildEntitiesShape [
	etitiesShapes := model duplicationEntities keys
		collect: [ :anEntity | 
			| composite border cloneBoxs |
			cloneBoxs := self buildCloneShapes: anEntity.
			border := RSBorder new
				color: Color black;
				width: 2.
			composite := RSComposite new.
			composite shapes: cloneBoxs.
			composite border: border.
			composite color: Color white.
			composite model: anEntity.
			composite @ RSDraggable.
			composite padding: 10.
			composite
				when: RSMouseClick
				do: [ :event | self processEntityClickEvent: event ] ]
		as: RSGroup.
	RSGridLayout new
		gapSize: 200;
		on: etitiesShapes.
	etitiesShapes
		@
			(RSLabeled new
				text:
					[ :elt | elt name , String cr , 'dupRate: ' , elt duplicationRate asString ])
]

{ #category : #accessing }
DuplicationBrowserRoassalViewByEntity >> cloneShapes [
	cloneShapes
		ifNil: [ cloneShapes := etitiesShapes flatCollect: #nodes ].
	^ cloneShapes
]

{ #category : #hooks }
DuplicationBrowserRoassalViewByEntity >> colorBoxsUsing: element [
	model updateFragmentColorFor: element model.
	^ self cloneShapes
		do:
			[ :aCloneShape | aCloneShape color: (model colorFor: aCloneShape model) ]
]

{ #category : #initialization }
DuplicationBrowserRoassalViewByEntity >> drawOn: aCanvas [
	aCanvas @ RSDraggableCanvas.
	aCanvas @ RSZoomableCanvas.
	self buildEntitiesShape.
	
	aCanvas addAll: etitiesShapes.
	aCanvas @ RSCanvasController.
	canvas := aCanvas.
	^ aCanvas
]

{ #category : #api }
DuplicationBrowserRoassalViewByEntity >> highlight: anEntity [
	canvas shapes
		detect: [ :shape | shape model = anEntity ]
		ifFound: [ :founded | self colorBoxsUsing: founded ]
		ifNone: [  ]
]

{ #category : #initialization }
DuplicationBrowserRoassalViewByEntity >> processCloneClickEvent: evt [
	| shape |
	shape := evt shape.
	self cloneShapes
		do: [ :aCloneShape | 
			aCloneShape model clonedFragment = shape model clonedFragment
				ifFalse: [ aCloneShape color: Color gray ] ].
	model selectedFragmentLocation: shape model.
	model
		freezeDuring: [ PWBApplication current globallySelect: shape model ]
]

{ #category : #initialization }
DuplicationBrowserRoassalViewByEntity >> processEntityClickEvent: evt [
	| shape |
	shape := evt shape.
	self colorBoxsUsing: shape.
	model
		freezeDuring: [ PWBApplication current
				globallySelect: (FamixTypeGroup with: shape model).
			model selected: shape model ]
]
