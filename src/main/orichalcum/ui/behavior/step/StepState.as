package orichalcum.ui.behavior.step 
{

	public class StepState 
	{
		
		static public const DISABLED:IStepState = new StepDisabledState;
		static public const ENABLED:IStepState = new StepEnabledState;
		static public const MOVING:IStepState = new StepMovingState;
		
	}

}