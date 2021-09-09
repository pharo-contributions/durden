Class {
	#name : #SpDropInContainer,
	#superclass : #SpPresenter,
	#instVars : [
		'dragHere',
		'presenters',
		'installingStrategy',
		'newLayoutBlock'
	],
	#category : #'Durden-Spec-DragDrop'
}

{ #category : #initialization }
SpDropInContainer >> acceptDrop: aBlock [
 	dragHere acceptDrop: aBlock
]

{ #category : #initialization }
SpDropInContainer >> beLeftToRight [

	newLayoutBlock := [ SpBoxLayout newLeftToRight ].
	self resetLayout
]

{ #category : #initialization }
SpDropInContainer >> beTopToBottom [

	newLayoutBlock := [ SpBoxLayout newTopToBottom ].
	self resetLayout
]

{ #category : #accessing }
SpDropInContainer >> borderWidth: anInteger [ 
	 dragHere borderWidth: anInteger.
	dragHere borderColor: Color black .
]

{ #category : #'drag and drop' }
SpDropInContainer >> dropEnabled: aBoolean [ 
	dragHere dropEnabled: aBoolean 
]

{ #category : #initialization }
SpDropInContainer >> initializePresenters [

	super initializePresenters.

	presenters := OrderedCollection new.
	dragHere := self instantiate: SpDragHere.
	dragHere borderWidth: 2.
	dragHere dropInto: self.
	self borderWidth: 2.
	self wantsDrop: [ :transfer :destination | 
		self shouldAcceptTransfer: transfer into: destination ].
	self acceptDrop: [ :transfer :destination | 
		self installTransfer: transfer into: destination ].
	self beTopToBottom
]

{ #category : #initialization }
SpDropInContainer >> install: aPresenter [

	| newPresenter |
	newPresenter := aPresenter adaptToDropInto: self.
	newPresenter owner: self.
	presenters add: newPresenter.
	layout removeAll.
	presenters do: [ :p | layout add: p ].

	(presenters anySatisfy: [ :p | p isDropInContainer ]) ifFalse: [ 
		layout add: dragHere height: 10 ].
	^ newPresenter
]

{ #category : #initialization }
SpDropInContainer >> installTransfer: transfer into: destination [

	(destination install: transfer passenger) owner: self.
	transfer passenger hasBeenReinstalled
]

{ #category : #'as yet unclassified' }
SpDropInContainer >> installedPresenters [

	^ presenters
]

{ #category : #initialization }
SpDropInContainer >> isDropInContainer [	
	^ true
]

{ #category : #initialization }
SpDropInContainer >> newLayout [

	^ newLayoutBlock value
]

{ #category : #testing }
SpDropInContainer >> noteThatWidgetHasBeenClosed: aPresenter [

	presenters remove: aPresenter.
	layout removeAll.
	presenters do: [ :p | layout add: p ].
	(presenters anySatisfy: [ :p | p isDropInContainer ]) ifFalse: [ 
		presenters
			ifEmpty: [ layout add: dragHere ]
			ifNotEmpty: [ layout add: dragHere height: 10 ] ]
]

{ #category : #initialization }
SpDropInContainer >> resetLayout [

	layout := self newLayout.
	presenters do: [ :p | layout add: p ].
	layout add: dragHere
]

{ #category : #initialization }
SpDropInContainer >> shouldAcceptTransfer: aTransfer into: aDestination [

	(aTransfer isKindOf: SpTransferMorph) ifFalse: [ ^ false ].
	^ aTransfer passenger canBeAdaptedToDropInto: aDestination
]

{ #category : #initialization }
SpDropInContainer >> wantsDrop: aBlock [
 	dragHere wantsDrop: aBlock
]
