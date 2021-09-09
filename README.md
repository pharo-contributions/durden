# Tyler Durden
Simple tiler 

It adds two kinds of spec presenters: 

SpDragMe button (when pressed the button it activates the drag operation). 
This button requires the setting up of a passanger to drop. 
When used in a widget to allow this widget to be drag-dropped

You can just initialize the button as follow. 
```
initializePresenters
 super initializePresenters.
...
 button := self instantiate: SpDragMe.
 button passenger: self
```

The second kind of presenter is the SpDropInContainer, which has 3 flavors: 

  SpDropInContainer container that uses topBottom and leftToRight box layout 
  SpDropInPanedContainer container that uses topBottom and leftToRight paned layout (with two sub SpDropInContainer)
  SpDropInDragableContainer which is a widget that contains either SpDropInContainer or SpDropInPanedContainer and gives a SpDragMe button to compose the container into other containers.
  

The following script creates a paned container (left-to-right) that on the left has a top-to-bottom simple dropin-container and on the right a draggable container configured to show paned container top-to-bottom. 

  
```
layerOne := SpDropInPanedContainer new beLeftToRight .
layerOne left install: (SpDropInContainer new beTopToBottom).

draggable := SpDropInDragableContainer new.
draggable bePanedContainer; beTopToBottom .
layerOne right install: (draggable).
layerOne openWithSpec
   
```

You can play with this window by simply spawning a drag-me button

```
dragMe := SpDragMe new.
dragMe openWithSpec. 
```




