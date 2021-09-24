Class {
	#name : #SpMultiDropInContainer,
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
SpMultiDropInContainer >> acceptDrop: aBlock [
 	dragHere acceptDrop: aBlock
]

{ #category : #initialization }
SpMultiDropInContainer >> beLeftToRight [

	newLayoutBlock := [ SpBoxLayout newLeftToRight ].
	self resetLayout
]

{ #category : #initialization }
SpMultiDropInContainer >> beTopToBottom [

	newLayoutBlock := [ SpBoxLayout newTopToBottom ].
	self resetLayout
]

{ #category : #accessing }
SpMultiDropInContainer >> borderWidth: anInteger [ 
	 dragHere borderWidth: anInteger.
	dragHere borderColor: Color black .
]

{ #category : #'drag and drop' }
SpMultiDropInContainer >> dropEnabled: aBoolean [ 
	dragHere dropEnabled: aBoolean 
]

{ #category : #initialization }
SpMultiDropInContainer >> ensureNoLoopWith: aSp [
	| current | 
	current := self. 
	[ current isNil ] whileFalse: [ 
		current owner = aSp ifTrue: [ ^ self error: 'Invalid looping composition' ].
		current := current owner. 
	]
]

{ #category : #initialization }
SpMultiDropInContainer >> initializePresenters [

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
SpMultiDropInContainer >> install: aPresenter [

	| newPresenter |
	newPresenter := aPresenter adaptToDropInto: self.
	presenters add: newPresenter.
	layout removeAll.
	presenters do: [ :p | layout add: p ].

	(presenters anySatisfy: [ :p | p isDropInContainer ]) ifFalse: [ 
		layout add: dragHere height: 10 ].
	^ newPresenter
]

{ #category : #initialization }
SpMultiDropInContainer >> installTransfer: transfer [

	self installTransfer: transfer into: self
]

{ #category : #initialization }
SpMultiDropInContainer >> installTransfer: transfer into: destination [
	| installed | 
	self ensureNoLoopWith: transfer passenger. 
	transfer passenger hasBeenReinstalled.
	installed := (self install: transfer passenger).
	installed owner: self.
]

{ #category : #'as yet unclassified' }
SpMultiDropInContainer >> installedPresenters [

	^ presenters
]

{ #category : #initialization }
SpMultiDropInContainer >> isDropInContainer [	
	^ true
]

{ #category : #initialization }
SpMultiDropInContainer >> newLayout [

	^ newLayoutBlock value
]

{ #category : #testing }
SpMultiDropInContainer >> noteThatWidgetHasBeenClosed: aPresenter [

	presenters remove: aPresenter.
	layout removeAll.
	presenters do: [ :p | layout add: p ].
	(presenters anySatisfy: [ :p | p isDropInContainer ]) ifFalse: [ 
		presenters
			ifEmpty: [ layout add: dragHere ]
			ifNotEmpty: [ layout add: dragHere height: 10 ] ]
]

{ #category : #initialization }
SpMultiDropInContainer >> resetLayout [

	layout := self newLayout.
	presenters do: [ :p | layout add: p ].
	layout add: dragHere
]

{ #category : #initialization }
SpMultiDropInContainer >> shouldAcceptTransfer: aTransfer into: aDestination [

	(aTransfer isKindOf: SpTransferMorph) ifFalse: [ ^ false ].
	^ aTransfer passenger canBeAdaptedToDropInto: aDestination
]

{ #category : #initialization }
SpMultiDropInContainer >> wantsDrop: aBlock [
 	dragHere wantsDrop: aBlock
]
