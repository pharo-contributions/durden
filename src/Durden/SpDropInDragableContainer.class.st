"
I am a draggable container. 
I am configurable in my layout and kind of internal container. 
"
Class {
	#name : #SpDropInDragableContainer,
	#superclass : #SpPresenter,
	#instVars : [
		'toolbar',
		'dropInContainer',
		'window',
		'containerClass'
	],
	#category : #'Durden-Spec-DragDrop'
}

{ #category : #specs }
SpDropInDragableContainer class >> defaultSpec [

	^ SpBoxLayout newTopToBottom  
		  add: #toolbar height: self toolbarHeight ;
		  add: #dropInContainer
]

{ #category : #initialization }
SpDropInDragableContainer >> adaptToDropInto: aDestination [
	window ifNotNil: [window close]. 
]

{ #category : #initialization }
SpDropInDragableContainer >> beLeftToRight [
	dropInContainer beLeftToRight
]

{ #category : #initialization }
SpDropInDragableContainer >> beNormalContainer [

	dropInContainer := self instantiate: SpSingleDropInContainer.
]

{ #category : #initialization }
SpDropInDragableContainer >> bePanedContainer [

	dropInContainer := self instantiate: SpDropInPanedContainer
]

{ #category : #initialization }
SpDropInDragableContainer >> beTopToBottom [

	dropInContainer beTopToBottom
]

{ #category : #'initialize-release' }
SpDropInDragableContainer >> close [

	owner noteThatWidgetHasBeenClosed: self
]

{ #category : #initialization }
SpDropInDragableContainer >> initializePresenters [

	super initializePresenters.
	toolbar := self newToolbar.
	toolbar addItem: self newDragMeButton.
	toolbar addItem: (self newToolbarButton
			 label: 'X';
			 action: [ self close ];
			 yourself).
	self beNormalContainer
]

{ #category : #initialization }
SpDropInDragableContainer >> initializeWindow: aWindow [ 
	window := aWindow.
]

{ #category : #initialization }
SpDropInDragableContainer >> isDropInContainer [	
	^ true
]
