"
I am a Paned container, i split in two containers with a resizing bar. 
I can be set to have a left / right ""single drop in"" or ""multiple drop in"", and i can be also set the layout to be bottomUp or leftRight. 
"
Class {
	#name : #SpDropInPanedContainer,
	#superclass : #SpPresenter,
	#instVars : [
		'left',
		'right',
		'newLayoutBlock'
	],
	#category : #'Durden-Spec-DragDrop'
}

{ #category : #'be multiple' }
SpDropInPanedContainer >> beLeftMultiple [

	self setLeftMultiple.
	self resetLayout
]

{ #category : #'be single' }
SpDropInPanedContainer >> beLeftSingle [
	self setLeftSingle.
	self resetLayout
]

{ #category : #initialization }
SpDropInPanedContainer >> beLeftToRight [
	newLayoutBlock := [ SpPanedLayout newLeftToRight ].
	self resetLayout
]

{ #category : #'be multiple' }
SpDropInPanedContainer >> beMultiple [
	self setMultiple.
	self resetLayout.
]

{ #category : #'be multiple' }
SpDropInPanedContainer >> beRightMultiple [
	self setRightMultiple.
	self resetLayout
]

{ #category : #'be single' }
SpDropInPanedContainer >> beRightSingle [
	self setRightSingle.
	self resetLayout
]

{ #category : #'be single' }
SpDropInPanedContainer >> beSingle [
	self setSingle. 
	self resetLayout.
]

{ #category : #initialization }
SpDropInPanedContainer >> beTopToBottom [
	newLayoutBlock := [ SpPanedLayout newTopToBottom ].
	self resetLayout
]

{ #category : #initialization }
SpDropInPanedContainer >> initializePresenters [
	super initializePresenters.
	
	self setSingle. 
	self beTopToBottom.
	
]

{ #category : #initialization }
SpDropInPanedContainer >> isDropInContainer [	
	^ true
]

{ #category : #accessing }
SpDropInPanedContainer >> left [
	^ left
]

{ #category : #initialization }
SpDropInPanedContainer >> newLayout [

	^ newLayoutBlock value
]

{ #category : #initialization }
SpDropInPanedContainer >> resetLayout [

	layout := self newLayout.
	layout
		add: left;
		add: right
]

{ #category : #accessing }
SpDropInPanedContainer >> right [
	^ right
]

{ #category : #'set single multiple' }
SpDropInPanedContainer >> setLeftMultiple [

	left := self instantiate: SpMultiDropInContainer
]

{ #category : #'set single multiple' }
SpDropInPanedContainer >> setLeftSingle [

	left := self instantiate: SpSingleDropInContainer
]

{ #category : #'set single multiple' }
SpDropInPanedContainer >> setMultiple [

	self setLeftMultiple.
	self setRightMultiple 
]

{ #category : #'set single multiple' }
SpDropInPanedContainer >> setRightMultiple [
	right := self instantiate: SpMultiDropInContainer
]

{ #category : #'set single multiple' }
SpDropInPanedContainer >> setRightSingle [
	right := self instantiate: SpSingleDropInContainer
]

{ #category : #'set single multiple' }
SpDropInPanedContainer >> setSingle [

	self setLeftSingle.
	self setRightSingle.
]
