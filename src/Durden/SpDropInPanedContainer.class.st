"
Similar to DropInContainer, but accepts two children (2 SpDropInContainer) arranged in a SpPanedLayout (thus they can be resized).

Layout can be horizontal (#beLeftToRight) or vertical (#beTopToBottom)
"
Class {
	#name : #SpDropInPanedContainer,
	#superclass : #SpPresenter,
	#instVars : [
		'left',
		'right',
		'newLayoutBlock'
	],
	#category : #'Durden-Spec-DragDrop'
}

{ #category : #initialization }
SpDropInPanedContainer >> beLeftToRight [

	newLayoutBlock := [ SpPanedLayout newLeftToRight ].
	self resetLayout
]

{ #category : #initialization }
SpDropInPanedContainer >> beTopToBottom [

	newLayoutBlock := [ SpPanedLayout newTopToBottom ].
	self resetLayout
]

{ #category : #initialization }
SpDropInPanedContainer >> initializePresenters [

	super initializePresenters.

	left := self instantiate: SpDropInContainer.
	right := self instantiate: SpDropInContainer.
	self beTopToBottom
]

{ #category : #initialization }
SpDropInPanedContainer >> isDropInContainer [	
	^ true
]

{ #category : #accessing }
SpDropInPanedContainer >> left [
	^ left
]

{ #category : #initialization }
SpDropInPanedContainer >> newLayout [

	^ newLayoutBlock value
]

{ #category : #initialization }
SpDropInPanedContainer >> resetLayout [

	layout := self newLayout.
	layout
		add: left;
		add: right
]

{ #category : #accessing }
SpDropInPanedContainer >> right [
	^ right
]
