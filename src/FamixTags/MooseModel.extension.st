Extension { #name : #MooseModel }

{ #category : #'*FamixTags' }
MooseModel >> allTags [
	| tags |
	tags := self privateState
		attributeAt: #allTags
		ifAbsentPut: [ OrderedCollection new ].
	tags
		ifEmpty: [ tags := FAMIXTag allInstances
				select: [ :tag | tag mooseModel = self ].
			self privateState attributeAt: #allTags put: tags ].
	^ tags
]

{ #category : #'*FamixTags' }
MooseModel >> futureActionTags [
	FAMIXTag new
		name: 'Obsolette';
		mooseModel: self;
		color: Color red.
	FAMIXTag new
		name: 'Not sure';
		mooseModel: self;
		color: Color yellow.
	FAMIXTag new
		name: 'To be refactored';
		mooseModel: self;
		color: Color orange
]

{ #category : #'*FamixTags' }
MooseModel >> resetTags [
	self allTags do: [ :t | t reset ].
	self privateState attributeAt: #allTags put: OrderedCollection new.

]

{ #category : #'*FamixTags' }
MooseModel >> tagNamed: aString [
	| tags |
	tags := self allTags.
	^ tags
		detect: [ :o | o name = aString ]
		ifNone: [ self error: 'Tag not found' ]
]
