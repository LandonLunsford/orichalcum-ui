package orichalcum.ui.behavior.pan 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.utils.setTimeout;

	[SWF(width="500",height="500")]
	public class SmallPanDemo extends Sprite 
	{
		private var _view:Sprite;
		private var _nav:Pan;
		
		public function SmallPanDemo()
		{
			
			_view = new Sprite;
			
			const totalNodes:int = 15;
			for (var i:int = 0; i < totalNodes; i++)
			{
				const nodeView:Sprite = new Sprite;
				//nodeView.graphics.beginFill((i & 1) == 1 ? 0x345678 : 0x56789a);
				nodeView.graphics.beginFill(0xffffff / totalNodes * i);
				nodeView.graphics.drawRect(0, 0, 100, 100);
				nodeView.graphics.endFill();
				nodeView.x = i * nodeView.width;
				_view.addChild(nodeView);
			}
			//_view.y = stage.stageHeight * 0.5 - _view.height * 0.5;
			
			
			
			// scaling screws bounds up
			
			_nav = new Pan(stage);
			_nav.target = _view;
			_nav.verticle = false;
			//_nav.lockX = true;
			
			const hardBounds:Rectangle = new Rectangle(
				50,
				0,
				_nav.hardBounds.width - 100,
				_view.getBounds(stage).height
			);
			const softBounds:Rectangle = hardBounds.clone();
			softBounds.x += 100;
			softBounds.width -= 200;
			
			_nav.hardBounds = softBounds;
			_nav.softBounds = hardBounds;
			
			
			
			addChild(_view);
			
			scaleX = scaleY = 0.5;
			
			trace(_nav.hardBounds, _view.getBounds(stage))
			
			const hardBoundsView:Sprite = new Sprite;
			hardBoundsView.graphics.lineStyle(2, 0xabcdef);
			hardBoundsView.graphics.drawRect(hardBounds.x, hardBounds.y, hardBounds.width, hardBounds.height);
			//hardBoundsView.y = stage.stageHeight * 0.5 - hardBoundsView.height * 0.5;
			stage.addChild(hardBoundsView);
			
			const softBoundsView:Sprite = new Sprite;
			softBoundsView.graphics.lineStyle(2, 0xfedcba);
			softBoundsView.graphics.drawRect(softBounds.x, softBounds.y, softBounds.width, softBounds.height);
			//softBoundsView.y = stage.stageHeight * 0.5 - softBoundsView.height * 0.5;
			stage.addChild(softBoundsView);
			
			//_nav.x = 200;
			//setTimeout(function():void {
				//_nav.velocityX = -2000;
				//
				//_nav.state = PanState.PANNING;
			//}, 1000);

		}
		
	}

}
