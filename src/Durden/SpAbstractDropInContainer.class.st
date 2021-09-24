Class {
	#name : #SpAbstractDropInContainer,
	#superclass : #SpPresenter,
	#instVars : [
		'dragHere',
		'installingStrategy'
	],
	#category : #'Durden-Spec-DragDrop'
}

{ #category : #initialization }
SpAbstractDropInContainer >> acceptDrop: aBlock [
 	dragHere acceptDrop: aBlock
]

{ #category : #accessing }
SpAbstractDropInContainer >> borderWidth: anInteger [ 
	 dragHere borderWidth: anInteger.
	dragHere borderColor: Color black .
]

{ #category : #'drag and drop' }
SpAbstractDropInContainer >> dropEnabled: aBoolean [ 
	dragHere dropEnabled: aBoolean 
]

{ #category : #initialization }
SpAbstractDropInContainer >> ensureNoLoopWith: aSp [
	| current | 
	current := self. 
	[ current isNil ] whileFalse: [ 
		current owner = aSp ifTrue: [ ^ self error: 'Invalid looping composition' ].
		current := current owner. 
	]
]

{ #category : #initialization }
SpAbstractDropInContainer >> initializePresenters [

	super initializePresenters.


	dragHere := self instantiate: SpDragHere.
	dragHere borderWidth: 2.
	dragHere dropInto: self.
	self borderWidth: 2.
	self wantsDrop: [ :transfer :destination | 
		self shouldAcceptTransfer: transfer into: destination ].
	self acceptDrop: [ :transfer :destination | 
		self installTransfer: transfer into: destination ]
]

{ #category : #initialization }
SpAbstractDropInContainer >> install: aPresenter [
	self subclassResponsibility 
]

{ #category : #initialization }
SpAbstractDropInContainer >> installTransfer: transfer [

	self installTransfer: transfer into: self
]

{ #category : #initialization }
SpAbstractDropInContainer >> installTransfer: transfer into: destination [
	| installed | 
	self ensureNoLoopWith: transfer passenger. 
	transfer passenger hasBeenReinstalled.
	installed := (self install: transfer passenger).
	installed owner: self.
]

{ #category : #initialization }
SpAbstractDropInContainer >> isDropInContainer [	
	^ true
]

{ #category : #initialization }
SpAbstractDropInContainer >> newLayout [
	^ self subclassResponsibility 
]

{ #category : #initialization }
SpAbstractDropInContainer >> noteThatWidgetHasBeenClosed: aPresenter [
	^ self subclassResponsibility 
]

{ #category : #initialization }
SpAbstractDropInContainer >> resetLayout [

	layout := self newLayout.
]

{ #category : #initialization }
SpAbstractDropInContainer >> shouldAcceptTransfer: aTransfer into: aDestination [

	(aTransfer isKindOf: SpTransferMorph) ifFalse: [ ^ false ].
	^ aTransfer passenger canBeAdaptedToDropInto: aDestination
]

{ #category : #initialization }
SpAbstractDropInContainer >> wantsDrop: aBlock [
 	dragHere wantsDrop: aBlock
]
