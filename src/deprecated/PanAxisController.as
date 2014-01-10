package orichalcum.ui.behavior.pan 
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.geom.Rectangle;

	internal class PanAxisController 
	{
		
		public function setValue(value:Number, focus:Number, view:DisplayObject, layers:Array):void
		{
			//_target.x = value;
			//const progress:Number = MathUtil.limit((_target.x / (_focusX - _target.width)), 0, 1);
			//for each(var layer:DisplayObject in _parallaxLayers)
			//{
				//layer.x = (_focusX - layer.width) * progress;
			//}
		}
		
		public function constrain(view:DisplayObject, viewBounds:Rectangle, _hardBounds:Rectangle):Boolean
		{
			//const viewBounds:Rectangle = target.getBounds(stage);
			//var _hardBounds:Rectangle = Rectangles.globalToLocal(stage, target, this._hardBounds);
			//var applied:Boolean;
			//if (viewBounds.left > _hardBounds.left)
			//{
				//_viewX = _hardBounds.left;
				//applied = true;
			//}
			//else if (viewBounds.right < _hardBounds.right)
			//{
				//_viewX = _hardBounds.right - target.width;
				//applied = true;
			//}
			//if (viewBounds.top > _hardBounds.top)
			//{
				//_viewY = _hardBounds.top;
				//applied = true;
			//}
			//else if (viewBounds.bottom < _hardBounds.bottom)
			//{
				//_viewY = _hardBounds.bottom - target.height;
				//applied = true;
			//}
		}
		
		public function pressure():void
		{
			//const viewBounds:Rectangle = target.getBounds(stage);
			//const inverseDamping:Number = 1 - _panDamping;
			//if (viewBounds.left > _softBounds.left)
			//{
				//trace('left')
				//_viewX += (_softBounds.left - viewBounds.left) * inverseDamping;
			//}
			//else if (viewBounds.right < _softBounds.right)
			//{
				//trace('right')
				//_viewX += (_softBounds.right - viewBounds.right) * inverseDamping;
			//}
			//if (viewBounds.top > _softBounds.top)
			//{
				//trace('top')
				//_viewY += (_softBounds.top - viewBounds.top) * inverseDamping;
			//}
			//else if (viewBounds.bottom < _softBounds.bottom)
			//{
				//trace('bottom')
				//_viewY += (_softBounds.bottom - viewBounds.bottom) * inverseDamping;
			//}
		}
		
	}

}