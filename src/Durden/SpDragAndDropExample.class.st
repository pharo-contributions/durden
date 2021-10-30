Class {
	#name : #SpDragAndDropExample,
	#superclass : #Object,
	#instVars : [
		'dropIn',
		'dragButton'
	],
	#category : #'Durden-examples'
}

{ #category : #examples }
SpDragAndDropExample >> buttonLabelTo: aPresenter [
	^'I am a button to be dragged into the ' , (self describe: aPresenter)
]

{ #category : #examples }
SpDragAndDropExample >> createDraggableWith: aDraggableClass [

	dragButton := aDraggableClass new
		label: 'Drag me into the ' , (self describe: dropIn) ;
		color: Color orange  ;
		openWithSpec;
		yourself.
	
	self setWindowTitle: dragButton.
	dragButton owner window position: dropIn owner window position + (200@50)
]

{ #category : #examples }
SpDragAndDropExample >> createDropableWith: aDropableClass [
	dropIn := aDropableClass new
		borderWidth: 1 ;
		openWithSpec ;
		yourself.
	self setWindowTitle: dropIn.
]

{ #category : #examples }
SpDragAndDropExample >> describe: aPresenter [
	^aPresenter class name
]

{ #category : #examples }
SpDragAndDropExample >> dragButtonLabel [
	dragButton label: 'I am a button to be dragged into the ' , (self describe: dropIn)
]

{ #category : #examples }
SpDragAndDropExample >> example01 [
	<script: 'self new example01'>
	"s simple drag button and drop-in area that will inform user when the button is dropped"
	
	self createDropableWith: SpDragHere.
	dropIn acceptDrop: [:a :b | self inform: (self describe: dropIn) , ' received drop: ' , (self describe: dragButton)].

	self createDraggableWith: SpDragMe.
	dragButton passenger: dragButton.

]

{ #category : #examples }
SpDragAndDropExample >> example02 [
	<script: 'self new example02'>
	"s simple drag button and a DropInContainer that will accept the dropped button"

	self createDropableWith: SpSingleDropInContainer.

	self createDraggableWith: SpDragMe.
	dragButton passenger: dragButton.
]

{ #category : #examples }
SpDragAndDropExample >> example03 [
	<script: 'self new example03'>
	"s drag button that closes when dropped and a DropInContainer that will accept the dropped button"

	self createDropableWith: SpSingleDropInContainer.

	self createDraggableWith: SpClosableDragMe.
	dragButton passenger: dragButton.
]

{ #category : #examples }
SpDragAndDropExample >> inform: aString [
	UIManager default inform: aString
]

{ #category : #private }
SpDragAndDropExample >> setWindowTitle: aPresenter [
	aPresenter owner title: 'a ', aPresenter class name.

]
