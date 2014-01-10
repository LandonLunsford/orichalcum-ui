package orichalcum.ui 
{
	import flash.geom.Point;
	import flash.system.Capabilities;
	import orichalcum.utility.MathUtil;

	public class Viewport 
	{
		
		static private var _instance:Viewport;
		
		static public function getInstance():Viewport
		{
			return _instance ||= new Viewport;
		}
		
		private var _dimensions:Point;
		private var _aspectRatio:Point;
		
		public function Viewport() 
		{
			_dimensions = new Point(Capabilities.screenResolutionX, Capabilities.screenResolutionY);
			
			const ratio:Point = MathUtil.ratio(_dimensions.x, _dimensions.y);
			_aspectRatio = ratio.x > ratio.y ? new Point(ratio.x, ratio.y) : new Point(ratio.y, ratio.x);
		}
		
		public function get aspectRatio():Point
		{
			return _aspectRatio;
		}
		
		public function get dimensions():Point
		{
			return _dimensions;
		}
		
	}

}