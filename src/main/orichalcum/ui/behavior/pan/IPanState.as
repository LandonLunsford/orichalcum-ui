package orichalcum.ui.behavior.pan 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public interface IPanState 
	{
		/**
		 * Names should not be bound to event names
		 * Idea being that I can remap these behaviors to different events
		 */
		
		function onMouseDown(context:Pan):void;
		function onMouseUp(context:Pan):void;
		function onEnterFrame(context:Pan):void;
	}

}