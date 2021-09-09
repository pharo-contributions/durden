Class {
	#name : #SpMorphicDraggerAdapter,
	#superclass : #SpMorphicButtonAdapter,
	#instVars : [
		'transferMorph'
	],
	#category : #'Durden-Spec-DragDrop'
}

{ #category : #factory }
SpMorphicDraggerAdapter >> newButton [

	^ DragMe
		  on: self
		  getState: #state
		  action: #action
		  label: #label
		  menu: #menu:
]

{ #category : #accessing }
SpMorphicDraggerAdapter >> performAction: event [

	transferMorph := self model transferPassenger buildWithSpec.
	transferMorph dragHand: event hand .
	transferMorph
		align: transferMorph draggedMorph topLeft
		with: event position.
	transferMorph dragTransferType: self model dragTransferType.

	event hand grabMorph: transferMorph
]

{ #category : #factory }
SpMorphicDraggerAdapter >> startDrag: event [

	transferMorph := self model transferPassenger buildWithSpec.
	transferMorph
		align: transferMorph draggedMorph topLeft
		with: event position.
	transferMorph dragTransferType: self model dragTransferType.

	event hand grabMorph: transferMorph
]
