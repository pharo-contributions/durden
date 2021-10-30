"
I am a ""drag"" button. 
I am not actually dragged, but clicking on me will allow to drag a passenger (typically a larger SpPresenter containing me)
I therefore require a passenger to transfer that must be set before hand . 

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
SpDragMe >> passenger: aWidget [
	"the widget 'carried' by this drag button"
	passenger := aWidget
]

{ #category : #'as yet unclassified' }
SpDragMe >> transferPassenger [
	^ SpTransferPresenter new
		  transfer: passenger;
		  from: self;
		  yourself
]
