package orichalcum.ui 
{

	public class Dimensions 
	{
		private var _width:Number;
		private var _height:Number;
		private var _depth:Number;
		
		public function Dimensions(width:Number = 1, height:Number = 1, depth:Number = 1)
		{
			_width = width;
			_height = height;
			_depth = depth;
		}
		
		public function get width():Number 
		{
			return _width;
		}
		
		public function get height():Number
		{
			return _height;
		}
		
		public function get depth():Number 
		{
			return _depth;
		}
		
		public function volume():Number
		{
			return width * height * depth;
		}
		
		public function clone():Dimensions
		{
			return new Dimensions(width, height, depth);
		}
		
		public function times(value:Dimensions):Dimensions
		{
			return value
				? new Dimensions(width * value.width, height * value.height, depth * value.depth)
				: clone();
		}
		
		public function divide(value:Dimensions):Dimensions
		{
			return value
				? new Dimensions(width / value.width, height / value.height, depth / value.depth)
				: clone();
		}
		
		public function inverse():Dimensions
		{
			return new Dimensions(1 / width, 1 / height, 1 / depth);
		}
		
		public function toString():String
		{
			return width + 'x' + height + 'x' + depth;
		}
		
	}

}