"
I accept dropped presenters and i extend my surgace for 
"
Class {
	#name : #SpMultiDropInContainer,
	#superclass : #SpAbstractDropInContainer,
	#instVars : [
		'presenters',
		'newLayoutBlock'
	],
	#category : #'Durden-Spec-DragDrop'
}

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

{ #category : #initialization }
SpMultiDropInContainer >> initializePresenters [

	super initializePresenters.
	presenters := OrderedCollection new.
	self beTopToBottom
]

{ #category : #initialization }
SpMultiDropInContainer >> install: aPresenter [

	| newPresenter |
	newPresenter := aPresenter adaptToDropInto: self.
	presenters add: newPresenter.
	layout removeAll.
	presenters do: [ :p | layout add: p ].
	self shouldHideDragHere ifFalse: [ layout add: dragHere height: 10 ].
	^ newPresenter
]

{ #category : #'as yet unclassified' }
SpMultiDropInContainer >> installedPresenters [

	^ presenters flatCollect: [ :a | 
		  (a respondsTo: #installedPresenters)
			  ifTrue: [ a installedPresenters ]
			  ifFalse: [ { a } ] ]
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

	super resetLayout.
	presenters do: [ :p | layout add: p ].
	layout add: dragHere
]

{ #category : #initialization }
SpMultiDropInContainer >> shouldHideDragHere [

	^ presenters anySatisfy: [ :p | p isDropInContainer ]
]
