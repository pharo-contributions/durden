"
I am a morphic pane that implements that allows the definition of accepting or rejecting drops according to valuable objects (block by example )
"
Class {
	#name : #DragHere,
	#superclass : #PanelMorph,
	#instVars : [
		'onPrompteForDragging',
		'onPrompteForAccepting'
	],
	#category : #'Durden-Morphic-DragDrop'
}

{ #category : #'as yet unclassified' }
DragHere >> acceptDroppingMorph: aBlock [

	onPrompteForAccepting := aBlock
]

{ #category : #'as yet unclassified' }
DragHere >> acceptDroppingMorph: aTransferMorph event: anEvent [

	^ onPrompteForAccepting ifNotNil: [ 
		  onPrompteForAccepting cull: aTransferMorph cull: anEvent ]
]

{ #category : #'as yet unclassified' }
DragHere >> wantsDroppedMorph: aBlock [ 
	onPrompteForDragging := aBlock
]

{ #category : #'as yet unclassified' }
DragHere >> wantsDroppedMorph: aMorph event: evt [

	^ onPrompteForDragging
		  ifNil: [ self dropEnabled ]
		  ifNotNil: [ onPrompteForDragging cull: aMorph cull: evt ]
]
