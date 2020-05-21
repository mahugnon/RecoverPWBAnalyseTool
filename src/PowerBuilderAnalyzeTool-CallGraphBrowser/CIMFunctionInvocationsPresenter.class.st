Class {
	#name : #CIMFunctionInvocationsPresenter,
	#superclass : #CIMRoassalPresenter,
	#instVars : [
		'invocations'
	],
	#category : #'PowerBuilderAnalyzeTool-CallGraphBrowser-TreeBase-Presenters'
}

{ #category : #examples }
CIMFunctionInvocationsPresenter class >> run [
	<example>
	self new openWithSpec
]

{ #category : #util }
CIMFunctionInvocationsPresenter >> buildPopupOn: aCanvas [
	| invs text |
	aCanvas edges
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
			aRSEdge @ (RSPopup text: text) ]
]

{ #category : #accessing }
CIMFunctionInvocationsPresenter >> pwbMooseModel [
	| data |
	invocations := guiModel selected incomingInvocations.
	data := Set withAll: (invocations collectAsSet: #sender).
	data add: guiModel selected.
	^ FamixTypeGroup withAll: data
]

{ #category : #initialization }
CIMFunctionInvocationsPresenter >> setConnexionOn: aRSEdge [
	aRSEdge
		moveBehind;
		connectFromAll: [ :each | 
			each = guiModel selected
				ifTrue: [ invocations collectAsSet: #sender ]
				ifFalse: [ #() ] ]
			to: #yourself
]
