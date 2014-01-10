package orichalcum.ui.event 
{
	import flash.events.Event;

	public class IOEvent extends Event 
	{
		static public const DRAG_START:String = 'IOEvent.DRAG_START';
		static public const DRAG_END:String = 'IOEvent.DRAG_END';
		static public const DRAG_MOVE:String = 'IOEvent.DRAG_MOVE';
		static public const DRAG_CONSTRAIN:String = 'IOEvent.DRAG_CONSTRAIN';
		static public const PAN_START:String = 'IOEvent.DRAG_CONSTRAIN';
		static public const PAN_MOVE:String = 'IOEvent.PAN_MOVE';
		static public const PAN_END:String = 'IOEvent.PAN_END';
		
		public function IOEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false)
		{
			super(type, bubbles, cancelable);
		}
		
		public override function clone():Event 
		{ 
			return new IOEvent(type, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("IOEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}