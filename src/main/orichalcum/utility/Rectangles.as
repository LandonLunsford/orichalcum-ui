package orichalcum.utility 
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	public class Rectangles 
	{
		
		static public function globalToLocal(stage:Stage, view:DisplayObject, rectangle:Rectangle):Rectangle
		{
			if (stage == view || !stage || !view || !rectangle) return rectangle;
			
			//rectangle.topLeft = view.globalToLocal(rectangle.topLeft);
			//rectangle.bottomRight = view.globalToLocal(rectangle.bottomRight);
			
			var topLeft:Point = view.globalToLocal(rectangle.topLeft);
			var bottomRight:Point = view.globalToLocal(rectangle.bottomRight);
			
			
			//return rectangle;
			return new Rectangle(topLeft.x, topLeft.y, bottomRight.x - topLeft.x, bottomRight.y - topLeft.y);
		}
		
	}

}