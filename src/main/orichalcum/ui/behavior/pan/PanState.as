package orichalcum.ui.behavior.pan 
{
	
	public class PanState 
	{
		static public const DISABLED:IPanState = new PanDisabledState;
		static public const ENABLED:IPanState = new PanEnabledState;
		static public const LISTENING:IPanState = new PanListeningState;
		static public const DRAGGING:IPanState = new PanDraggingState;
		static public const PANNING:IPanState = new PanPanningState;
	}

}