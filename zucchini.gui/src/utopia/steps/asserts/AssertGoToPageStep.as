package utopia.steps.asserts
{
	import pl.ydp.automation.execution.IAutomationStep;
	import pl.ydp.automation.scripts.steps.base.Step;
	
	public class AssertGoToPageStep extends Step implements IAutomationStep
	{
		public function AssertGoToPageStep(resolvedPattern:RegExp)
		{
			super(resolvedPattern);
		}
		
		public function set variables(variables:Array):void
		{
		}
		
		public function execute(scriptName:String):void
		{
		}
	}
}