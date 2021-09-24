"
I am a version of the dropin container that does not allow more than a single presenter. 
"
Class {
	#name : #SpSingleDropInContainer,
	#superclass : #SpAbstractDropInContainer,
	#instVars : [
		'presenter'
	],
	#category : #'Durden-Spec-DragDrop'
}

{ #category : #initialization }
SpSingleDropInContainer >> initializePresenters [

	super initializePresenters.

	self resetLayout.
]

{ #category : #initialization }
SpSingleDropInContainer >> install: aPresenter [

	presenter := aPresenter adaptToDropInto: self.
	layout removeAll.
	layout add: presenter.
	^ presenter
]

{ #category : #initialization }
SpSingleDropInContainer >> newLayout [
	^ SpBoxLayout newTopToBottom 
]

{ #category : #testing }
SpSingleDropInContainer >> noteThatWidgetHasBeenClosed: aPresenter [

	self assert: presenter = aPresenter.

	presenter := nil.
	layout removeAll.
	layout add: dragHere
]

{ #category : #initialization }
SpSingleDropInContainer >> resetLayout [

	layout := self newLayout.
	layout add: (presenter ifNotNil: [ presenter ] ifNil: [ dragHere ])
]
