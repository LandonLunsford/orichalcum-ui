package orichalcum.ui.behavior.pan 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	internal class PanDraggingState extends PanDisabledState
	{
		
		override public function onMouseUp(context:Pan):void 
		{
			context._endDrag();
			context._startPan();
		}
		
		override public function onEnterFrame(context:Pan):void 
		{
			const view:DisplayObject = context._target;
			context._previousX = view.x;
			context._previousY = view.y;
			context._viewX = context._viewStartX + context._stage.mouseX - context._dragStartX; 
			context._viewY = context._viewStartY + context._stage.mouseY - context._dragStartY;
			
			if (context._previousX != view.x
			|| context._previousY != view.y)
			{
				context._applyHardConstraints();
				context._moveDrag();
			}
			
		}
		
	}

}