Class {
	#name : #PWBDuplicationListBrowserModel,
	#superclass : #PWBAbstractModel,
	#category : #'PowerBuilderAnalyzeTool-Models'
}

{ #category : #'default actions' }
PWBDuplicationListBrowserModel >> exportToCSV [
	| fileReference |
	fileReference := UITheme builder
		chooseForSaveFileReference: 'Your title here'
		extensions: #('csv')
		path: ''.
	fileReference
		ifNotNil: [ fileReference
				writeStreamDo: [ :stream | 
					self writeMooseModelOn: stream.
					Notification signal: 'Save successful!' ] ]
]

{ #category : #'default actions' }
PWBDuplicationListBrowserModel >> exportToCSV1 [
	| fileReference |
	fileReference := UITheme builder
		chooseForSaveFileReference: 'Your title here'
		extensions: #('csv')
		path: ''.
	fileReference
		ifNotNil: [ fileReference
				writeStreamDo: [ :stream | 
					self writeMooseModelOn1: stream.
					Notification signal: 'Save successful!' ] ]
]

{ #category : #'accessing ' }
PWBDuplicationListBrowserModel >> pwbMooseModel: aCollection [
	super pwbMooseModel: aCollection.
	pwbBrowser update
]

{ #category : #writing }
PWBDuplicationListBrowserModel >> writeMooseModelOn1: aStream [
	aStream
		<< 'Entities with duplications';
		cr.
	pwbMooseModel
		do: [ :dupFragment | 
			| members |
			members := dupFragment members.
			1 to: members size - 1 do: [ :iter | 
				| member |
				member := members at: iter.
				aStream
					<< member entity parentType name;
					<< '. ';
					<< member name;
					<< ' (';
					<< member startLineInOriginalFile asString;
					<< '->';
					<< member endLineInOriginalFile asString;
					<< '); ' ].
			aStream
				<< members last entity parentType name;
				<< '. ';
				<< members last name;
				<< ' (';
				<< members last endLineInOriginalFile asString;
				<< '->';
				<< members last endLineInOriginalFile asString;
				<< ')';
				cr ]
]

{ #category : #writing }
PWBDuplicationListBrowserModel >> writeMooseModelOn: aStream [
	aStream
		<< 'Entities with duplications';
		cr.
	pwbMooseModel
		do: [ :dupFragment | 
			| members |
			members := dupFragment members.
			1 to: members size - 1 do: [ :iter | 
				| member |
				member := members at: iter.
				aStream
					<< member entity parentType name;
					<< '. ';
					<< member name;
					<< ' (';
					<< member startLine asString;
					<< '->';
					<< member endLine asString;
					<< '); ' ].
			aStream
				<< members last entity parentType name;
				<< '. ';
				<< members last name;
				<< ' (';
				<< members last startLine asString;
				<< '->';
				<< members last endLine asString;
				<< ')';
				cr ]
]
