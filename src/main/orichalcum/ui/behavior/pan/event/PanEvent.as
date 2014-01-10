package orichalcum.ui.behavior.pan.event 
{
	import flash.events.Event;

	public class PanEvent extends Event 
	{
		
		static public const DRAG_START:String = 'PanEvent.DRAG_START';
		static public const DRAG_END:String = 'PanEvent.DRAG_END';
		static public const DRAG_MOVE:String = 'PanEvent.DRAG_MOVE';
		static public const PAN_START:String = 'PanEvent.PAN_START';
		static public const PAN_MOVE:String = 'PanEvent.PAN_MOVE';
		static public const PAN_END:String = 'PanEvent.PAN_END';
		static public const PAN_CONSTRAINED:String = 'PanEvent.PAN_CONSTRAINED';
		
		public function PanEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
		} 
		
		public override function clone():Event 
		{ 
			return new PanEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("PanEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}