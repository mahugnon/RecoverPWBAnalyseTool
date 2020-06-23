Class {
	#name : #CIMFunctionInvocationsPresenter,
	#superclass : #CIMRoassalPresenter,
	#instVars : [
		'invocations'
	],
	#category : #'PowerBuilderAnalyzeTool-CallGraphBrowser-Roassal'
}

{ #category : #examples }
CIMFunctionInvocationsPresenter class >> run [
	<example>
	self new openWithSpec
]

{ #category : #initialization }
CIMFunctionInvocationsPresenter >> buildLayoutOn: aCanvas [
	layout := RSRadialTreeLayout new
		verticalGap: 150;
		horizontalGap: 100;
		on: aCanvas nodes
]

{ #category : #util }
CIMFunctionInvocationsPresenter >> buildPopupOn: aCanvas [
	| invs text |
"	aCanvas edges
		do: [ :aRSEdge | 
			invs := invocations select: [ :inv | inv sender = aRSEdge from model ].
			text := Text new.
			text
				append:
					(String
						streamContents: [ :stream | 
							invs
								do: [ :inv | 
									stream
										<< inv sender name;
										<< ' -> ';
										<< guiModel selected name;
										<< (QueryInvocationArgumentsString runOn: inv);
										cr ] ]).
			aRSEdge @ (RSPopup text: text) ]"
]

{ #category : #accessing }
CIMFunctionInvocationsPresenter >> pwbMooseModel [
	| data |
	invocations := (guiModel selected incomingInvocations
		, guiModel selected outgoingInvocations) asSet.
	data := {guiModel selected invokingBehaviours.
	guiModel selected invokedBehaviours} flatten asSet
		reject: [ :e | e parentType isNil ].
	data add: guiModel selected.
	^ FamixTypeGroup withAll: data
]

{ #category : #initialization }
CIMFunctionInvocationsPresenter >> setConnexionOn: aRSEdge [
	aRSEdge
		moveBehind;
		connectFromAll: [ :each | 
			each = guiModel selected
				ifTrue: [ guiModel selected invokingBehaviours ]
				ifFalse: [ #() ] ]
			to: #yourself.
	aRSEdge
		connectFrom: [ :each | 
			each = guiModel selected
				ifTrue: [ each ]
				ifFalse: [  ] ]
		toAll: #invokedBehaviours
]

{ #category : #initialization }
CIMFunctionInvocationsPresenter >> setIncomingConnexionOn: aRSEdge [
	aRSEdge
		moveBehind;
		connectFromAll: [ :each | 
			each = guiModel selected
				ifTrue: [ guiModel selected invokingBehaviours ]
				ifFalse: [ #() ] ]
			to: #yourself
]

{ #category : #initialization }
CIMFunctionInvocationsPresenter >> setOutgoingConnexionOn: aRSEdge [
	aRSEdge
		connectFrom: [ :each | 
			each = guiModel selected
				ifTrue: [ #yourself ]
				ifFalse: [  ] ]
		toAll: #invokedBehaviours
]
