package orichalcum.ui.behavior 
{
	import flash.display.DisplayObject;
	
	
	public interface IBehavior 
	{
		function addTo(target:DisplayObject):void;
		function removeFrom(target:DisplayObject):void;
	}

}