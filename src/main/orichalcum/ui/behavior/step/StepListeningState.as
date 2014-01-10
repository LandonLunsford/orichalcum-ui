package orichalcum.ui.behavior.step 
{


	internal class StepListeningState extends StepDisabledState
	{
		
		override public function onMouseUp(context:Step):void 
		{
			context.state = StepState.ENABLED;
		}
		
		override public function onEnterFrame(context:Step):void 
		{
			const x:Number = context._stage.mouseX;
			const y:Number = context._stage.mouseY;
			const dx:Number = x - context._mouseDownX;
			const dy:Number = y - context._mouseDownY;
			if ( dx * dx + dy * dy > context._minimumDistanceToActivate * context._minimumDistanceToActivate)
			{
				const mouseVelocityX:Number = x - context._previousMouseX;
				
				const velocityX:Number = Math.abs(mouseVelocityX) > context._minimumSpeedToRun
					? mouseVelocityX < 0 ? -context._runningSpeed : context._runningSpeed
					: mouseVelocityX < 0 ? -context._walkingSpeed : context._walkingSpeed
				
				context._velocityX = velocityX;
				context._startMove();
			}
			
			context._previousMouseX = x;
			context._previousMouseY = y;
		}
		
	}

}