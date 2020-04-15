Class {
	#name : #PWBToRemoveDuplicationListBrowserModel,
	#superclass : #PWBAbstractModel,
	#category : #'PowerBuilderAnalyzeTool-Models'
}

{ #category : #'default actions' }
PWBToRemoveDuplicationListBrowserModel >> exportToCSV [
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

{ #category : #'accessing ' }
PWBToRemoveDuplicationListBrowserModel >> pwbMooseModel: aDictionnary [
	super pwbMooseModel: aDictionnary.
	pwbBrowser update
]

{ #category : #writing }
PWBToRemoveDuplicationListBrowserModel >> writeMooseModelOn: aStream [
	aStream
		<< 'Object PWB';
		nextPut: $,;
		<< 'Function';
		nextPut: $,;
		<< 'Number of clones';
		cr.
	pwbMooseModel
		keysAndValuesDo: [ :key :value | 
			aStream
				<< key parentType name;
				nextPut: $,;
				<< key name;
				nextPut: $,;
				<< value size asString;
				cr ]
]
