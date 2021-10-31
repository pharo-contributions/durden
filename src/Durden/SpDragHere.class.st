"
I work as an area that accepts drops.
I will install the drop into a presenter (my #dropInto:)
I cannot be shown by my self, but i can be embedded into different containers. 

"
Class {
	#name : #SpDragHere,
	#superclass : #SpContainerPresenter,
	#instVars : [
		'dropInto'
	],
	#category : #'Durden-Spec-DragDrop'
}

{ #category : #specs }
SpDragHere class >> adapterName [ 
	 ^ #SpMorphicDragHereAdapter
]

{ #category : #'changing suspended state' }
SpDragHere >> dropInto: aDropIn [
	"the widget that will accept the drop"
	dropInto := aDropIn
]

{ #category : #initialization }
SpDragHere >> initialize [
	super initialize.
	self dropEnabled: true.
]

{ #category : #'changing suspended state' }
SpDragHere >> install: aPresenter [
	^ dropInto install: aPresenter
]

{ #category : #testing }
SpDragHere >> noteThatWidgetHasBeenClosed: anAlceSourceCodeWidget [
	self flag: 'to remove ?'.
	dropInto noteThatWidgetHasBeenClosed: anAlceSourceCodeWidget
]
