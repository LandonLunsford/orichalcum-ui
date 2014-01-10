package orichalcum.ui.behavior.pan 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.Capabilities;
	import orichalcum.animation.Animation;
	import orichalcum.animation.factory.animate;
	import orichalcum.ui.behavior.pan.event.PanEvent;
	import orichalcum.ui.Constant;
	import orichalcum.utility.FunctionUtil;
	import orichalcum.utility.MathUtil;
	
	/**
	 * Candidates for null object pattern
	 * The pattern will improve performance and coherence but increase memory footprint of behavior
	 * 
	 * applyHardConstraints - x v y
	 * applySoftConstraints - x v y
	 * applyParallaxX
	 * applyParallaxY
	 * 
	 */
	public class Pan extends EventDispatcher 
	{
		private var defaultBounds:Rectangle;
		private var defaultFocus:Point;
		internal var _animation:Animation = animate(this);
		internal var _stage:Stage;
		internal var _target:DisplayObject;
		internal var _state:IPanState = PanState.ENABLED;
		internal var _panDamping:Number = 0.9;
		internal var _panSnapping:Number = 0.25;
		internal var _minimumDistanceToDrag:Number;
		internal var _hardBounds:Rectangle;
		internal var _softBounds:Rectangle;
		internal var _focusX:Number;
		internal var _focusY:Number;
		internal var _parallaxLayers:Array;
		
		internal var _mouseDownX:Number;
		internal var _mouseDownY:Number;
		internal var _viewStartX:Number;
		internal var _viewStartY:Number;
		internal var _dragStartX:Number;
		internal var _dragStartY:Number;
		internal var _previousX:Number;
		internal var _previousY:Number;
		
		private function X_AXIS_CONTROLLER(value:Number):void
		{
			_target.x = value;
			_applyParallaxX();
		};
		
		private function Y_AXIS_CONTROLLER(value:Number):void
		{
			_target.y = value;
			_applyParallaxY();
		};
		
		private var _horizontalState:Function = X_AXIS_CONTROLLER;
		private var _verticalState:Function = Y_AXIS_CONTROLLER;
		
		/**
		 * when axis is locked
		 * ignore axis parralax, value set and bounding
		 */
		
		public function Pan(stage:Stage) 
		{
			_stage = stage;
			_stage.addEventListener(MouseEvent.MOUSE_DOWN, stage_onMouseDown, false, 0, true);
			_stage.addEventListener(MouseEvent.MOUSE_UP, stage_onMouseUp, false, 0, true);
			_stage.addEventListener(Event.ENTER_FRAME, stage_onEnterFrame, false, 0, true);
			
			defaultBounds = Capabilities.isDebugger
				? new Rectangle(0,0,stage.stageWidth, stage.stageHeight)
				: new Rectangle(0,0,Capabilities.screenResolutionX, Capabilities.screenResolutionY);
			
			defaultFocus = new Point(defaultBounds.width * 0.5, defaultBounds.height * 0.5);
			
			_hardBounds = defaultBounds;
			_softBounds = defaultBounds;
			_focusX = defaultBounds.width * 0.5;
			_focusY = defaultBounds.height * 0.5;
			
			const lesserDimension:Number = defaultBounds.x < defaultBounds.y ? defaultBounds.x : defaultBounds.x;
			_minimumDistanceToDrag = lesserDimension * 0.01;
		}
		
		public function dispose():void
		{
			_stage.removeEventListener(MouseEvent.MOUSE_DOWN, stage_onMouseDown);
			_stage.removeEventListener(MouseEvent.MOUSE_UP, stage_onMouseUp);
			_stage.removeEventListener(Event.ENTER_FRAME, stage_onEnterFrame);
			_stage = null;
			_target = null;
			_state = null;
			_parallaxLayers = null;
			_hardBounds = null;
			_softBounds = null;
		}
		
		public function get stage():Stage 
		{
			return _stage;
		}
		
		public function get target():DisplayObject 
		{
			return _target;
		}
		
		public function set target(value:DisplayObject):void 
		{
			_target = value ? value : Constant.NULL_VIEW;
		}
		
		public function get state():IPanState 
		{
			return _state;
		}
		
		public function set state(value:IPanState):void 
		{
			_state = value || PanState.DISABLED;
		}
		
		public function get x():Number 
		{
			return -_viewX;
		}
		
		public function set x(value:Number):void 
		{
			_viewX = -value;
		}
		
		public function get y():Number 
		{
			return -_viewY;
		}
		
		public function set y(value:Number):void 
		{
			_viewY = -value;
		}
		
		public function get velocityX():Number
		{
			return _target.x - _previousX;
		}
		
		public function set velocityX(value:Number):void 
		{
			_previousX = _target.x - value;
		}
		
		public function get velocityY():Number
		{
			return _target.y - _previousY;
		}
		
		public function set velocityY(value:Number):void 
		{
			_previousY = _target.y - value;
		}
		
		public function get focusX():Number
		{
			return _focusX;
		}
		
		public function set focusX(value:Number):void 
		{
			_focusX = value;
			_applyParallaxX();
		}
		
		public function get focusY():Number
		{
			return _focusY;
		}
		
		public function set focusY(value:Number):void 
		{
			_focusY = value;
			_applyParallaxY();
		}
		
		public function disable():void
		{
			state = PanState.DISABLED;
		}
		
		public function enable():void
		{
			state = PanState.ENABLED;
		}
		
		public function get enabled():Boolean
		{
			return state === PanState.ENABLED;
		}
		
		public function set enabled(value:Boolean):void
		{
			value ? enable() : disable();
		}
		
		public function get panDamping():Number 
		{
			return _panDamping;
		}
		
		public function set panDamping(value:Number):void 
		{
			_panDamping = value;
		}
		
		public function get panSnapping():Number 
		{
			return _panSnapping;
		}
		
		public function set panSnapping(value:Number):void 
		{
			_panSnapping = value;
		}
		
		public function get hardBounds():Rectangle 
		{
			return _hardBounds;
		}
		
		public function set hardBounds(value:Rectangle):void 
		{
			_hardBounds = value;
		}
		
		public function get softBounds():Rectangle 
		{
			return _softBounds;
		}
		
		public function set softBounds(value:Rectangle):void 
		{
			_softBounds = value;
		}
		
		public function get parallaxLayers():Array 
		{
			return _parallaxLayers;
		}
		
		public function set parallaxLayers(value:Array):void 
		{
			_parallaxLayers = value;
		}
		
		public function get horizontal():Boolean
		{
			return _horizontalState == X_AXIS_CONTROLLER;
		}
		
		public function set horizontal(value:Boolean):void
		{
			_horizontalState = value ? X_AXIS_CONTROLLER : FunctionUtil.NULL;
		}
		
		public function get verticle():Boolean
		{
			return _verticalState == Y_AXIS_CONTROLLER;
		}
		
		public function set verticle(value:Boolean):void
		{
			_verticalState = value ? Y_AXIS_CONTROLLER : FunctionUtil.NULL;
		}
		
		/**
		 * Center point on view with viewport center
		 */
		public function panTo(x:Number, y:Number, seconds:Number = 0.5, ease:Function = null):void
		{
			/**
			 * stage.mouseX, center on stage.mouseX
			 * 
			 * 
			 * (stage.stageWidth - stage.mouseX),
			 * 
			 */
			
			state = PanState.ENABLED;
			_animation.invalidate();
			_animation.from().x = -target.x;
			_animation.from().y = -target.y;
			
			_animation.to().x = x
			_animation.to().y = y
			
			_animation.seconds(seconds).ease(ease).goto(0).play();
		}
		
		/* PRIVATE PARTS */
		
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
		
		/* INTERNAL PARTS */
		
		internal function get _viewX():Number
		{
			return _target.x;
		}
		
		internal function set _viewX(value:Number):void
		{
			_horizontalState(value);
			//_viewX = value;
		}
		
		internal function get _viewY():Number
		{
			return _target.y;
		}
		
		internal function set _viewY(value:Number):void
		{
			_verticalState(value);
			//_viewY = value;
		}
		
		internal function _startDrag():void 
		{
			_viewStartX = target.x;
			_viewStartY = target.y;
			_dragStartX = stage.mouseX;
			_dragStartY = stage.mouseY;
			_state = PanState.DRAGGING;
			hasEventListener(PanEvent.DRAG_START)
				&& dispatchEvent(new PanEvent(PanEvent.DRAG_START));
		}
		
		internal function _moveDrag():void
		{
			hasEventListener(PanEvent.DRAG_START)
				&& dispatchEvent(new PanEvent(PanEvent.DRAG_MOVE));
		}
		
		internal function _endDrag():void
		{
			hasEventListener(PanEvent.DRAG_START)
				&& dispatchEvent(new PanEvent(PanEvent.DRAG_END));
		}
		
		internal function _startPan():void
		{
			_state = PanState.PANNING;
			hasEventListener(PanEvent.PAN_START)
				&& dispatchEvent(new PanEvent(PanEvent.PAN_START)); 
		}
		
		internal function _movePan(velocityX:Number, velocityY:Number):void
		{
			_viewX += velocityX * _panDamping;
			_viewY += velocityY * _panDamping;
			_applyHardConstraints();
			_applySoftConstraints();
			hasEventListener(PanEvent.PAN_MOVE)
				&& dispatchEvent(new PanEvent(PanEvent.PAN_MOVE)); 
		}
		
		internal function _endPan():void
		{
			_state = PanState.ENABLED;
			hasEventListener(PanEvent.PAN_END)
				&& dispatchEvent(new PanEvent(PanEvent.PAN_END)); 
		}
		
		/**
		 * dependencies
		 * view
		 * stage
		 * hardBounds
		 * ... everything apply parallax needs
		 */
		internal function _applyHardConstraints():void
		{
			if (_hardBounds == null) return;
			
			const viewBounds:Rectangle = target.getBounds(stage);
			var xScale:Number = target.scaleX;
			var yScale:Number = target.scaleY;
			var parent:DisplayObjectContainer = target.parent;
			while (parent != stage && parent != null)
			{
				xScale *= parent.scaleX;
				yScale *= parent.scaleY;
				parent = parent.parent;
			}
			
			//var applied:Boolean;
			if (viewBounds.left > _hardBounds.left)
			{
				_viewX = _hardBounds.left / xScale;
				//applied = true;
			}
			else if (viewBounds.right < _hardBounds.right)
			{
				_viewX = _hardBounds.right / xScale - target.width;
				//applied = true;
			}
			if (viewBounds.top > _hardBounds.top)
			{
				_viewY = _hardBounds.top / yScale;
				//applied = true;
			}
			else if (viewBounds.bottom < _hardBounds.bottom)
			{
				_viewY = _hardBounds.bottom / yScale - target.height;
				//applied = true;
			}
			
			//applied && hasEventListener(PanEvent.PAN_CONSTRAINED)
				//&& dispatchEvent(new PanEvent(PanEvent.PAN_CONSTRAINED));
		}
		
		internal function _applySoftConstraints():void
		{
			if (_softBounds == null) return;
			
			
			const viewBounds:Rectangle = target.getBounds(stage);
			if (viewBounds.left > _softBounds.left)
			{
				/*
					Supress velocity
				*/
				_previousX = _viewX;
				_viewX += (_softBounds.left - viewBounds.left) * _panSnapping;
			}
			else if (viewBounds.right < _softBounds.right)
			{
				_previousX = _viewX;
				_viewX += (_softBounds.right - viewBounds.right) * _panSnapping;
			}
			if (viewBounds.top > _softBounds.top)
			{
				_previousY = _viewY;
				_viewY += (_softBounds.top - viewBounds.top) * _panSnapping;
			}
			else if (viewBounds.bottom < _softBounds.bottom)
			{
				_previousY = _viewY;
				_viewY += (_softBounds.bottom - viewBounds.bottom) * _panSnapping;
			}
			
		}
		
		private function _applyParallaxX():void
		{
			const progress:Number = MathUtil.limit((_target.x / (_focusX - _target.width)), 0, 1);
			for each(var layer:DisplayObject in _parallaxLayers)
			{
				layer.x = (_focusX - layer.width) * progress;
			}
		}
		
		private function _applyParallaxY():void 
		{
			const progress:Number = MathUtil.limit((_target.y / (_focusY - _target.height)), 0, 1);
			for each(var layer:DisplayObject in _parallaxLayers)
			{
				layer.y = (_focusY - layer.height) * progress;
			}
		}
		
	}

}