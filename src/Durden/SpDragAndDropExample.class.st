Class {
	#name : #SpDragAndDropExample,
	#superclass : #Object,
	#category : #'Durden-examples'
}

{ #category : #examples }
SpDragAndDropExample class >> example01 [
	<script: 'self example01'>
	| draggable dropIn |
	dropIn := SpSingleDropInContainer new
		openWithSpec ;
		yourself.
	dropIn owner title: 'a SpSingleDropInContainer'.

	draggable := SpDragMe new
		openWithSpec ;
		label: 'I am a button to be dragged into a Sp...DropInContainer' ;
		yourself.
	draggable passenger: draggable.
]

{ #category : #'see class side' }
SpDragAndDropExample >> seeClassSide [ 
]
