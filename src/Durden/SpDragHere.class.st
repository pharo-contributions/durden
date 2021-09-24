"
I work as a container that accepts drops into. 
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

	dropInto := aDropIn
]

{ #category : #'changing suspended state' }
SpDragHere >> install: aPresenter [

	^ dropInto install: aPresenter
]

{ #category : #testing }
SpDragHere >> noteThatWidgetHasBeenClosed: anAlceSourceCodeWidget [

	dropInto noteThatWidgetHasBeenClosed: anAlceSourceCodeWidget
]
