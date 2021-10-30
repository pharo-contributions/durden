Class {
	#name : #SpClosableDragMe,
	#superclass : #SpDragMe,
	#category : #'Durden-examples'
}

{ #category : #testing }
SpClosableDragMe >> adaptToDropInto: aWidget [
	"close the window owning the drag button before installing the button in the dropIn"
	self owner close
]
