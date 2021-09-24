Class {
	#name : #SpSingleDropInContainer,
	#superclass : #SpPresenter,
	#instVars : [
		'dragHere',
		'presenter',
		'installingStrategy'
	],
	#category : #'Durden-Spec-DragDrop'
}

{ #category : #initialization }
SpSingleDropInContainer >> acceptDrop: aBlock [
 	dragHere acceptDrop: aBlock
]

{ #category : #accessing }
SpSingleDropInContainer >> borderWidth: anInteger [ 
	 dragHere borderWidth: anInteger.
	dragHere borderColor: Color black .
]

{ #category : #'drag and drop' }
SpSingleDropInContainer >> dropEnabled: aBoolean [ 
	dragHere dropEnabled: aBoolean 
]

{ #category : #initialization }
SpSingleDropInContainer >> ensureNoLoopWith: aSp [
	| current | 
	current := self. 
	[ current isNil ] whileFalse: [ 
		current owner = aSp ifTrue: [ ^ self error: 'Invalid looping composition' ].
		current := current owner. 
	]
]

{ #category : #initialization }
SpSingleDropInContainer >> initializePresenters [

	super initializePresenters.
	dragHere := self instantiate: SpDragHere.
	dragHere borderWidth: 2.
	dragHere dropInto: self.
	self borderWidth: 2.
	self wantsDrop: [ :transfer :destination | 
		self shouldAcceptTransfer: transfer into: destination ].
	self acceptDrop: [ :transfer :destination | 
		self installTransfer: transfer into: destination ].
	self resetLayout.
]

{ #category : #initialization }
SpSingleDropInContainer >> install: aPresenter [

	presenter := aPresenter adaptToDropInto: self.
	layout removeAll.
	layout add: presenter.
	^ presenter
]

{ #category : #initialization }
SpSingleDropInContainer >> installTransfer: transfer into: destination [
	| installed | 
	self ensureNoLoopWith: transfer passenger. 
	transfer passenger hasBeenReinstalled.
	installed := (self install: transfer passenger).
	installed owner: self.
]

{ #category : #initialization }
SpSingleDropInContainer >> isDropInContainer [	
	^ true
]

{ #category : #initialization }
SpSingleDropInContainer >> newLayout [
	^ SpBoxLayout newTopToBottom 
]

{ #category : #testing }
SpSingleDropInContainer >> noteThatWidgetHasBeenClosed: aPresenter [

	self assert: presenter = aPresenter.

	presenter := nil.
	layout removeAll.
	layout add: dragHere
]

{ #category : #initialization }
SpSingleDropInContainer >> resetLayout [

	layout := self newLayout.
	layout add: (presenter ifNotNil: [ presenter ] ifNil: [ dragHere ])
]

{ #category : #initialization }
SpSingleDropInContainer >> shouldAcceptTransfer: aTransfer into: aDestination [

	(aTransfer isKindOf: SpTransferMorph) ifFalse: [ ^ false ].
	^ aTransfer passenger canBeAdaptedToDropInto: aDestination
]

{ #category : #initialization }
SpSingleDropInContainer >> wantsDrop: aBlock [
 	dragHere wantsDrop: aBlock
]
