"
I am a morph that represents a button (kind of a clickable something) with all the configuration ready to activate ""start dragging"" feature. 
"
Class {
	#name : #DragMe,
	#superclass : #PluggableButtonMorph,
	#instVars : [
		'draggingAction'
	],
	#category : #'Durden-Morphic-DragDrop'
}

{ #category : #accessing }
DragMe >> badgeSelector: aString [ 

]

{ #category : #configuring }
DragMe >> configureWith: displayModel item: itemPresenter [
	displayModel configureButton: self item: itemPresenter
]

{ #category : #accessing }
DragMe >> getIconSelector: aSelector [

]

{ #category : #accessing }
DragMe >> getLabelSelector: aSelector [

	getLabelSelector := aSelector.
	self update: getLabelSelector
]

{ #category : #initialization }
DragMe >> initialize [

	super initialize.

	label := StringMorph
		         contents: 'DragMe'
		         font: StandardFonts buttonFont.
	self extent: label width + 6 @ (label height + 6).
	label position: self center - (label extent // 2).
	self addMorph: label.
	label lock
]

{ #category : #'event handling' }
DragMe >> performAction: event [

	"Inform the model that this button has been pressed. Sent by the controller when this button is pressed. If the button's actionSelector takes any arguments, they are obtained dynamically by sending the argumentSelector to the argumentsProvider"

	enabled ifFalse: [ ^ self ].
	askBeforeChanging ifTrue: [ model okToChange ifFalse: [ ^ self ] ].
	self actionBlock ifNotNil: [ ^ self actionBlock cull: event ].
	model performAction: event
]

{ #category : #'event handling' }
DragMe >> startDrag: event [

	event hand hasSubmorphs ifTrue: [ ^ self ].
	"Here I ensure at least one element is selected "
	event hand anyButtonPressed ifFalse: [ ^ self ].

	draggingAction value
]

{ #category : #'event handling' }
DragMe >> whenDraggingDo: aBlock [

	draggingAction := aBlock
]
