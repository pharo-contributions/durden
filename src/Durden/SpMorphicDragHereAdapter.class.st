Class {
	#name : #SpMorphicDragHereAdapter,
	#superclass : #SpMorphicContainerAdapter,
	#instVars : [
		'transferMorph'
	],
	#category : #'Durden-Spec-DragDrop'
}

{ #category : #factory }
SpMorphicDragHereAdapter >> buildWidget [

	^ DragHere new
		  changeProportionalLayout;
		  vResizing: #spaceFill;
		  hResizing: #spaceFill;
		  dragEnabled: self dragEnabled;
		  dropEnabled: self dropEnabled;
		  borderWidth: self borderWidth;
		  borderColor: self borderColor;
		  wantsDroppedMorph: [ :t | 
			  self presenter wantsDrop cull: t cull: self presenter ];
		  acceptDroppingMorph:
			  [ :t | self presenter acceptDrop cull: t cull: self presenter ]
				  yourself
]
