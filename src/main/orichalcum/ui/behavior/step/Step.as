package orichalcum.ui.behavior.step 
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import orichalcum.ui.Constant;


	public class Step 
	{
		internal var _stage:Stage;
		internal var _target:DisplayObject;
		internal var _state:IStepState = StepState.ENABLED;
		
		internal var _minimumDistanceToActivate:Number = 0;
		
		internal var _mouseDownX:Number;
		internal var _mouseDownY:Number;
		internal var _previousMouseX:Number;
		internal var _previousMouseY:Number;
		
		internal var _walkingSpeed:Number = 1;
		internal var _runningSpeed:Number = 2;
		internal var _velocityX:Number;
		
		// TODO
		// parent container that you conditionally move until it is out of viewport bounds -- then you resort to moving view
		internal var _environment:DisplayObject;
		
		
		public function Step(stage:Stage) 
		{
			_stage = stage;
			_stage.addEventListener(MouseEvent.MOUSE_DOWN, stage_onMouseDown, false, 0, true);
			_stage.addEventListener(MouseEvent.MOUSE_UP, stage_onMouseUp, false, 0, true);
			_stage.addEventListener(Event.ENTER_FRAME, stage_onEnterFrame, false, 0, true);
			
			const defaultBounds:Rectangle = Capabilities.isDebugger
				? new Rectangle(0, 0, stage.stageWidth, stage.stageHeight)
				: new Rectangle(0, 0, Capabilities.screenResolutionX, Capabilities.screenResolutionY);
			
			const lesserDimension:Number = defaultBounds.x < defaultBounds.y ? defaultBounds.x : defaultBounds.x;
			_minimumDistanceToActivate = lesserDimension * 0.01;
		}
		
		public function get stage():Stage 
		{
			return _stage;
		}
		
		public function set stage(value:Stage):void 
		{
			_stage = value;
		}
		
		public function get target():DisplayObject 
		{
			return _target;
		}
		
		public function set target(value:DisplayObject):void 
		{
			_target = value ? value : Constant.NULL_VIEW;
		}
		
		public function get state():IStepState 
		{
			return _state;
		}
		
		public function set state(value:IStepState):void 
		{
			_state = value || StepState.DISABLED;
		}
		
		public function get walkingSpeed():Number 
		{
			return _walkingSpeed;
		}
		
		public function set walkingSpeed(value:Number):void 
		{
			_walkingSpeed = value;
		}
		
		public function get runningSpeed():Number 
		{
			return _runningSpeed;
		}
		
		public function set runningSpeed(value:Number):void 
		{
			_runningSpeed = value;
		}
		
		
		
		
		
		
		private function stage_onMouseDown(event:MouseEvent):void 
		{
			state.onMouseDown(this);
		}
		
		private function stage_onMouseUp(event:MouseEvent):void 
		{
			state.onMouseUp(this);
		}
		
		private function stage_onEnterFrame(event:Event):void 
		{
			state.onEnterFrame(this);
		}
		
		
		
		
		
		internal function _startMove():void 
		{
			_state = StepState.MOVING;
		}
		
	}

}