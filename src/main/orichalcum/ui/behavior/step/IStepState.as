package orichalcum.ui.behavior.step 
{
	
	public interface IStepState 
	{
		/**
		 * Names should not be bound to event names
		 * Idea being that I can remap these behaviors to different events
		 */
		
		function onMouseDown(context:Step):void;
		function onMouseUp(context:Step):void;
		function onEnterFrame(context:Step):void;
		
	}

}