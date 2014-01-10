package orichalcum.ui.behavior.pan 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	internal class PanPanningState extends PanDisabledState
	{
		
		override public function onMouseDown(context:Pan):void 
		{
			context._startDrag();
		}
		
		override public function onEnterFrame(context:Pan):void 
		{
			const velocityX:Number = context.velocityX;
			const velocityY:Number = context.velocityY;
			context._previousX = context._viewX;
			context._previousY = context._viewY;
			
			const EPSILON:Number = 1;
			if (Math.abs(velocityX) < EPSILON
			&& Math.abs(velocityY) < EPSILON)
			{
				context._endPan();
			}
			else
			{
				context._movePan(velocityX, velocityY);
			}
			
		}
		
	}

}