package orichalcum.ui.behavior.pan 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	internal class PanEnabledState extends PanDisabledState
	{
		
		override public function onMouseDown(context:Pan):void 
		{
			//context._animation.stop();
			
			context._mouseDownX = context._stage.mouseX;
			context._mouseDownY = context._stage.mouseY;
			context.state = PanState.LISTENING;
		}
		
		override public function onEnterFrame(context:Pan):void 
		{
			context._applySoftConstraints();
		}
		
	}

}