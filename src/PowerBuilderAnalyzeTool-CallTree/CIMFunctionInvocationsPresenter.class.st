Class {
	#name : #CIMFunctionInvocationsPresenter,
	#superclass : #CIMRoassalPresenter,
	#category : #'PowerBuilderAnalyzeTool-CallTree-TreeBase-Presenters'
}

{ #category : #examples }
CIMFunctionInvocationsPresenter class >> run [
	<example>
	self new openWithSpec
]

{ #category : #initialization }
CIMFunctionInvocationsPresenter >> drawOn: aCanvas [
	| es eb borderWhite |
	aCanvas @ RSDraggableCanvas @ RSZoomableCanvas.
	es := (self pwbMooseModel
		collect: [ :modelElement | 
			| elipse |
			elipse := RSEllipse new
				draggable;
				size: 50;
				model: modelElement;
				color: (ColorFunction colorFor: modelElement);
				yourself.
			elipse
				when: RSMouseClick
				do: [ :event | self processEntityClickEvent: event ] ])
		as: RSGroup.
	es @ RSLabeled.
	aCanvas addAll: es.
	borderWhite := RSBorder new
		color: Color white;
		yourself.
	eb := RSEdgeBuilder arrowedLine
		canvas: aCanvas;
		shapes: es;
		markerEnd:
			((RSShapeFactory triangle
				extent: 10 @ 20;
				color: Color red;
				border: borderWhite;
				yourself) asMarker
				offset: 35;
				yourself);
		moveBehind;
		width: 2;
		connectFromAll: [ :each | each outgoingInvocationsCandidates ].
	RSTreeLayout new
		verticalGap: 500;
		on: aCanvas nodes.
	self legend: aCanvas.
	"	onDemand: 'Show legend';"
	aCanvas @ RSCanvasController.
	view := aCanvas.
	^ aCanvas
]

{ #category : #initialization }
CIMFunctionInvocationsPresenter >> legend: aCanvas [
	| legend |
	legend := RSLegend new.
	legend defaultLabel fontSize: 30.
	legend
		container: aCanvas;
		text: 'Each circle is a Powerbuilder user object ';
		text:
			'Each arrow is an invocationfrom its source function to the target function';
		text: 'Selected user object' withCircleColor: Color paleGreen;
		build
]
