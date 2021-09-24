"
I am a drag button. 
I require a passenger to transfer.
The passenger must be set before hand . 

"
Class {
	#name : #SpDragMe,
	#superclass : #SpButtonPresenter,
	#instVars : [
		'passenger'
	],
	#category : #'Durden-Spec-DragDrop'
}

{ #category : #specs }
SpDragMe class >> adapterName [

	^ #SpMorphicDragMeAdapter
]

{ #category : #accessing }
SpDragMe >> passenger: aSpColorPicker [ 
	passenger := aSpColorPicker
]

{ #category : #'as yet unclassified' }
SpDragMe >> transferPassenger [

	^ SpTransferPresenter new
		  transfer: passenger;
		  from: self;
		  yourself
]
