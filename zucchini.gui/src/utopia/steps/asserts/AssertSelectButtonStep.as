package utopia.steps.asserts
{
	import pl.ydp.automation.execution.IAutomationStep;
	import pl.ydp.automation.scripts.steps.base.Step;
	
	public class AssertSelectButtonStep extends Step implements IAutomationStep
	{
		public function AssertSelectButtonStep(resolvedPattern:RegExp)
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