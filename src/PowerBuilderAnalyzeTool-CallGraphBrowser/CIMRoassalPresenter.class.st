Class {
	#name : #CIMRoassalPresenter,
	#superclass : #SpPresenter,
	#instVars : [
		'diagram',
		'guiModel',
		'view',
		'currentFocus'
	],
	#category : #'PowerBuilderAnalyzeTool-CallGraphBrowser-TreeBase-Presenters'
}

{ #category : #specs }
CIMRoassalPresenter class >> defaultSpec [
	^ SpBoxLayout  newHorizontal
		add: #diagram;
		yourself
]

{ #category : #util }
CIMRoassalPresenter >> adapterFrom: aCollection [
  ^self pwbMooseModel select: [:each |  aCollection includes: each pwbMooseModel ]
]

{ #category : #accessing }
CIMRoassalPresenter >> application [
	^ owner application
]

{ #category : #initialization }
CIMRoassalPresenter >> buildEdgeOn: aCanvas [
	| borderWhite arrows |
	borderWhite := RSBorder new
		color: Color white;
		yourself.
	arrows := RSEdgeBuilder arrowedLine.
	arrows
		canvas: aCanvas;
		withBorderAttachPoint;
		objects: self pwbMooseModel;
		markerEnd:
			((RSShapeFactory triangle
				extent: 10 @ 15;
				color: Color red;
				border: borderWhite;
				yourself)
				asMarker;
				yourself);
		width: 3;
		moveBehind.
	self setConnexionOn: arrows


	"self buildePopupOnEdges: arrows"
]

{ #category : #initialization }
CIMRoassalPresenter >> buildLayoutOn: aCanvas [
	layout := RSCircleLayout new on: aCanvas nodes
]

{ #category : #util }
CIMRoassalPresenter >> buildPopupOn: aCanvas [
	self subclassResponsibility
]

{ #category : #initialization }
CIMRoassalPresenter >> buildShapesOn: aCanvas [
	aCanvas
		addAll:
			((self pwbMooseModel
				collect: [ :modelElement | 
					| elipse lbl |
					lbl := RSLabel new
						text: modelElement name;
						yourself.
					elipse := RSEllipse new
						size: lbl extent;
						extent: lbl extent + 10;
						model: modelElement;
						color: (ColorObject colorFor: modelElement);
						yourself.
					elipse @ self contextMenu.
					elipse
						when: RSMouseClick
						do: [ :event | self processEntityClickEvent: event ].
					RSComposite new
						draggable;
						model: modelElement;
						shapes: (RSGroup with: elipse with: lbl);
						yourself ]) as: RSGroup)
]

{ #category : #hooks }
CIMRoassalPresenter >> colorSelectedElement: element [
	currentFocus
		ifNotNil: [ currentFocus color: (ColorObject colorFor: currentFocus model) ].
	currentFocus := element.
	^ currentFocus color: Color paleGreen
]

{ #category : #initialization }
CIMRoassalPresenter >> contextMenu [
	^ RSMenuActivable new
		menuDo: [ :menu :element | 
			menu
				add: 'Tag element'
					target: element
					selector: #addTag
					argument: #();
				add: 'Remove tag'
					target: element
					selector: #unMark
					argument: #() ];
		yourself
]

{ #category : #initialization }
CIMRoassalPresenter >> contextMenuOn: aNode [
	aNode
		@
			(RSMenuActivable new
				menuDo: [ :menu :element | 
					menu
						add: 'Tag element'
							target: element
							selector: #addTag
							argument: #();
						add: 'Remove tag'
							target: element
							selector: #unMark
							argument: #() ];
				yourself)
]

{ #category : #accessing }
CIMRoassalPresenter >> diagram [
	^ diagram
]

{ #category : #accessing }
CIMRoassalPresenter >> diagram: anObject [
	diagram := anObject
]

{ #category : #initialization }
CIMRoassalPresenter >> drawOn: aCanvas [
	aCanvas @ RSDraggableCanvas @ RSZoomToFitCanvas.
	self buildShapesOn: aCanvas.
	self buildEdgeOn: aCanvas.
	self buildLayoutOn: aCanvas.
	"self contextMenuOn: aCanvas."
	self legend: aCanvas.
	aCanvas @ RSCanvasController.
	self buildPopupOn: aCanvas.
	view := aCanvas.
	self highlight: guiModel selected.
	^ aCanvas
]

{ #category : #accessing }
CIMRoassalPresenter >> guiModel [
	^ guiModel
]

{ #category : #accessing }
CIMRoassalPresenter >> guiModel: anObject [
	guiModel := anObject
]

{ #category : #util }
CIMRoassalPresenter >> highlight: anEntity [
	self
		colorSelectedElement: (view nodes detect: [ :el | el model = anEntity ]) nodes first
]

{ #category : #initialization }
CIMRoassalPresenter >> initializeDiagram [
	diagram := self instantiate: SpRoassalPresenter.
	diagram
		script: [ :canvas | 
			self drawOn: canvas.
			view := canvas ]
]

{ #category : #initialization }
CIMRoassalPresenter >> initializeWidgets [
  self initializeDiagram
]

{ #category : #initialization }
CIMRoassalPresenter >> legend: aCanvas [
	| legend |
	legend := RSLegend new.
	legend defaultLabel fontSize: 10.
	legend
		container: aCanvas;
		text: 'Each circle is a Powerbuilder class ';
		text:
			'Each arrow is a group of invocation from its source user class to the target class';
		text: 'Selected user class' withCircleColor: Color paleGreen;
		text: 'Deprecated class' withCircleColor: Color red;
		text: 'User object to refactor'
			withCircleColor: Color orange;
		text: 'Not sure of action to perform about the class'
			withCircleColor: Color yellow;
		build
]

{ #category : #initialization }
CIMRoassalPresenter >> processEntityClickEvent: evt [
	| element |
	element := evt shape.
	guiModel selected: element model.
	self colorSelectedElement: element.
	"guiModel
		freezeDuring: [ self application globallySelect: element model ]"
]

{ #category : #accessing }
CIMRoassalPresenter >> pwbMooseModel [
	^ self subclassResponsibility
]

{ #category : #initialization }
CIMRoassalPresenter >> setConnexionOn: aRSEdge [ 
self subclassResponsibility 
]

{ #category : #accessing }
CIMRoassalPresenter >> view [
	^ view
]
