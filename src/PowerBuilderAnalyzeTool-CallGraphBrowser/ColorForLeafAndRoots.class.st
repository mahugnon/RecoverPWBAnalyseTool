Class {
	#name : #ColorForLeafAndRoots,
	#superclass : #ColorFunction,
	#category : #'PowerBuilderAnalyzeTool-CallGraphBrowser-EntityColorStrategy'
}

{ #category : #private }
ColorForLeafAndRoots class >> accept: aMooseAdapter [
  ^aMooseAdapter outgoingInvocationsCandidates isEmpty or: [ aMooseAdapter incomingInvocations isEmpty ]
]

{ #category : #accessing }
ColorForLeafAndRoots >> color [
	^ Color fromHexString: '#EAD3A3'
]
