Extension { #name : #FamixPWBBehavioral }

{ #category : #'*PowerBuilderAnalyzeTool-CallGraphBrowser' }
FamixPWBBehavioral >> isNoisyMethod [
	^ self noisyMethods includes: self name asLowercase
]

{ #category : #'*PowerBuilderAnalyzeTool-CallGraphBrowser' }
FamixPWBBehavioral >> noisyMethods [
	^ #('sort' 'len' 'setnull' 'string' 'long' 'rowcount' 'Find' 'getitemdate' 'retrieve' 'isnull' 'setsort' 'getitemstring' 'isnull' 'left' 'setrow' 'upprt' 'trim' 'right' 'now' 'datetime' 'relativedate' 'today' 'triggerevent' 'replace' 'long' 'isnumber' 'getitemnumber' 'constructor' 'destroy')
]
