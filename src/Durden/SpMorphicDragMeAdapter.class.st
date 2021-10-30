"
I am a morphic adapter that puts together the DragMe morph with a SpDragMe spec widget
"
Class {
	#name : #SpMorphicDragMeAdapter,
	#superclass : #SpMorphicButtonAdapter,
	#instVars : [
		'transferMorph'
	],
	#category : #'Durden-Spec-DragDrop'
}

{ #category : #factory }
SpMorphicDragMeAdapter >> newButton [

	^ DragMe
		  on: self
		  getState: #state
		  action: #action
		  label: #label
		  menu: #menu:
]

{ #category : #accessing }
SpMorphicDragMeAdapter >> performAction: event [

	transferMorph := self model transferPassenger buildWithSpec.
	transferMorph dragHand: event hand .
	transferMorph
		align: transferMorph draggedMorph topLeft
		with: event position.
	transferMorph dragTransferType: self model dragTransferType.

	event hand grabMorph: transferMorph
]

{ #category : #factory }
SpMorphicDragMeAdapter >> startDrag: event [
	self flag: 'used ?'.
	1halt.
	transferMorph := self model transferPassenger buildWithSpec.
	transferMorph
		align: transferMorph draggedMorph topLeft
		with: event position.
	transferMorph dragTransferType: self model dragTransferType.

	event hand grabMorph: transferMorph
]

{ #category : #actions }
SpMorphicDragMeAdapter >> startDragging [

	widget startDragging
]
