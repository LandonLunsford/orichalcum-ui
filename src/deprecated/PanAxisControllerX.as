package orichalcum.ui.behavior.pan 
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.geom.Rectangle;
	import orichalcum.utility.MathUtil;

	internal class PanAxisControllerX extends PanAxisController
	{
		
		public function setValue(context:Pan, value:Number):void
		{
			context.target.x = value;
			const progress:Number = MathUtil.limit((context.target.x / (context.focusX - view.width)), 0, 1);
			for each(var layer:DisplayObject in context.parallaxLayers)
			{
				layer.x = (context.focusX - layer.width) * progress;
			}
		}
		
		public function constrain(view:DisplayObject, viewBounds:Rectangle, bounds:Rectangle):Boolean
		{
			//const viewBounds:Rectangle = target.getBounds(stage);
			//var _hardBounds:Rectangle = Rectangles.globalToLocal(stage, target, this._hardBounds);
			
			// should be direction....
			if (viewBounds.left > bounds.left)
			{
				_hardBounds.left;
				return true;
			}
			else if (viewBounds.right < bounds.right)
			{
				_viewX = bounds.right - target.width;
				return true;
			}
		}
		
		public function pressure():B
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