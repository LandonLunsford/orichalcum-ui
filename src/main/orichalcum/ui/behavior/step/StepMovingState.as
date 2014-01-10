package orichalcum.ui.behavior.step 
{
	import air.update.descriptors.StateDescriptor;
	import flash.display.Stage;


	internal class StepMovingState extends StepDisabledState
	{
		
		override public function onMouseUp(context:Step):void 
		{
			//context.state = StepState.ENABLED;
		}
		
		override public function onEnterFrame(context:Step):void 
		{
			const stage:Stage = context.stage;
			const mouseX:Number = stage.mouseX;
			const mouseY:Number = stage.mouseY;
			
			
			
			
			// detect change in motion
			// track total motion distance
			//context._x += context._velocityX;
			
			
			
			context._previousMouseX = mouseX;
			context._previousMouseY = mouseY;
			
			
			
			// notes below
			
			
			
			
			//var direction:String;
			//var deltaDistance:Number;
			//const mouseX:Number = _proxy.mouseX;
			//const mouseY:Number = _proxy.mouseY;
			//const velocityX:Number = mouseX - _previousX;
			//const velocityY:Number = mouseY - _previousY;
			//const fast:Boolean = velocityX * velocityX + velocityY * velocityY > _velocityLine * _velocityLine;
			//
			//if (velocityX == 0 && velocityY == 0)
			//{
				//direction = Direction.NONE;
			//}
			//else
			//{
				//const deltaDistanceX:Number = Math.abs(velocityX);
				//const deltaDistanceY:Number = Math.abs(velocityY);
				//
				//if (deltaDistanceX > deltaDistanceY)
				//{
					//direction = velocityX > 0 ? Direction.RIGHT : Direction.LEFT;
					//deltaDistance = deltaDistanceX;
				//}
				//else
				//{
					//direction = velocityY > 0 ? Direction.DOWN : Direction.UP;
					//deltaDistance = deltaDistanceY;
				//}
				//_totalSwipeDistance += deltaDistance;
			//}
			//
			//if (fast)
			//{
				//if (direction != _direction)
				//{
					//_totalSwipeDistance = _minimumSwipeDistance;
				//}
			//}
			//else
			//{
				//
			//}
			//
			//while (_totalSwipeDistance >= _minimumSwipeDistance)
			//{
				//_totalSwipeDistance -= _minimumSwipeDistance;
				//_moveSwipe(direction);
			//}
			//
			//_previousX = mouseX;
			//_previousY = mouseY;
		}
		
	}

}