Class {
	#name : #CIMUserObjectReferencesPresenter,
	#superclass : #CIMRoassalPresenter,
	#category : #'PowerBuilderAnalyzeTool-CallGraphBrowser-TreeBase-Presenters'
}

{ #category : #examples }
CIMUserObjectReferencesPresenter class >> run [
	<example>
	self new openWithSpec
]

{ #category : #util }
CIMUserObjectReferencesPresenter >> buildPopupOn: aCanvas [
	| names text |
	aCanvas edges
		do: [ :aRSEdge | 
			names := QueryIncomingBetweenPWBObject new
				runOn: aRSEdge to model
				with: aRSEdge from model.
			text := Text new.
			text
				append:
					(String
						streamContents: [ :stream | 
							names
								keysAndValuesDo: [ :key :value | 
									value
										do: [ :inv | 
											stream
												<< inv sender name;
												<< ' -> ';
												<< key name;
												<< (QueryInvocationArgumentsString runOn: inv);
												cr ] ] ]).
			aRSEdge @ (RSPopup text: text) ]
]

{ #category : #accessing }
CIMUserObjectReferencesPresenter >> pwbMooseModel [
	| senders |
	senders := guiModel selectedMethodsInvocationsSendersParents asSet.
	senders add: guiModel selected.
	^ senders
]

{ #category : #initialization }
CIMUserObjectReferencesPresenter >> setConnexionOn: aRSEdge [
	aRSEdge
		connectFromAll: [ :each | 
			each = self guiModel selected
				ifTrue: [ each incomingInvocationsSenders ]
				ifFalse: [ #() ] ]
		to: #yourself
]
