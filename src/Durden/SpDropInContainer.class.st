"
This is the base class to accept DropIn presenters.

It can arrange its ""children"" horizontally (#beLeftToRight) or vertically (#beTopToBottom)

It can accept unlimited number of DropIn by offering an empty space on the left or the bottom where new presenters can be droped

"
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
SpDropInContainer >> ensureNoLoopWith: aSp [
	| current | 
	current := self. 
	[ current isNil ] whileFalse: [ 
		current owner = aSp ifTrue: [ ^ self error: 'Invalid looping composition' ].
		current := current owner. 
	]
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
	presenters add: newPresenter.
	layout removeAll.
	presenters do: [ :p | layout add: p ].

	(presenters anySatisfy: [ :p | p isDropInContainer ]) ifFalse: [ 
		layout add: dragHere height: 10 ].
	^ newPresenter
]

{ #category : #initialization }
SpDropInContainer >> installTransfer: transfer into: destination [
	| installed | 
	self ensureNoLoopWith: transfer passenger. 
	transfer passenger hasBeenReinstalled.
	installed := (self install: transfer passenger).
	installed owner: self.
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
	self flag: 'It should be possible to have a container that accepts only 1 dropIn (ex: for PanedContainer'.
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
