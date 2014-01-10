package orichalcum.ui.behavior.pan 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	internal class PanListeningState extends PanDisabledState
	{
		
		override public function onMouseUp(context:Pan):void 
		{
			context.state = PanState.ENABLED;
		}
		
		override public function onEnterFrame(context:Pan):void 
		{
			const dx:Number = context._stage.mouseX - context._mouseDownX;
			const dy:Number = context._stage.mouseY - context._mouseDownY;
			if ( dx * dx + dy * dy > context._minimumDistanceToDrag * context._minimumDistanceToDrag)
			{
				context._startDrag();
			}
		}
		
	}

}