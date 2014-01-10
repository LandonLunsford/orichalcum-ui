package orichalcum.ui.behavior.pan 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	[SWF(width="300",height="200")]
	public class PanDemo extends Sprite 
	{
		[Embed(source="../../../../resources/Fantasy_wallpapers_301.jpg")]
		private var _0:Class;
		
		[Embed(source = "../../../../resources/parallax_1.png")]
		private var _1:Class;
		
		[Embed(source = "../../../../resources/parallax_2.png")]
		private var _2:Class;
		
		[Embed(source = "../../../../resources/parallax_3.png")]
		private var _3:Class;
		
		[Embed(source = "../../../../resources/parallax_4.png")]
		private var _4:Class;
		
		private var _layers:Array = [new _1, new _2, new _3, new _4];
		
		private var _nav:Pan;
		
		public function PanDemo()
		{
			for each(var layer:DisplayObject in _layers)
			{
				//layer.width = layer.width * 4;
				//layer.height = layer.height * 4;
				addChild(layer);
			}
			
			_nav = new Pan(stage);
			_nav.target = _layers.shift();
			_nav.parallaxLayers = _layers;
			
			const b:Rectangle = _nav.hardBounds;
			_nav.softBounds = new Rectangle(
				-b.width * 0.1,
				-b.width * 0.1,
				b.width + b.width * 0.2,
				b.height + b.width * 0.2
			);
			_nav.x = b.width * 0.5;
			_nav.y = b.height * 0.5;
		
			// cool effect
			//stage.addEventListener(Event.ENTER_FRAME, function(event:Event):void
			//{
				//_nav.focusX = stage.mouseX;
				//_nav.focusY = stage.mouseY;
				//_nav.focusX = defaultBounds.width - stage.mouseX;
				//_nav.focusY = defaultBounds.height - stage.mouseY;
			//});
			
			stage.addEventListener(MouseEvent.RIGHT_CLICK, function(event:MouseEvent):void
			{
				// most likey have to integrate like parallax
				_nav.panTo(stage.mouseX, stage.mouseY);
			});
		}
		
	}

}