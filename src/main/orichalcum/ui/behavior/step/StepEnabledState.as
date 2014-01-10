package orichalcum.ui.behavior.step 
{


	internal class StepEnabledState extends StepDisabledState
	{
		
		override public function onMouseDown(context:Step):void 
		{
			const x:Number = context._stage.mouseX;
			const y:Number = context._stage.mouseY;
			
			context._mouseDownX = x;
			context._mouseDownY = y;
			
			context._previousMouseX = x;
			context._previousMouseY = y;
			
			context.state = StepState.LISTENING;
		}
		
	}

}