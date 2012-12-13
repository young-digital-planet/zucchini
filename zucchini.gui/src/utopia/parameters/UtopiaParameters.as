package utopia.parameters
{
	import pl.ydp.automation.configuration.impl.parameters.DefaultAutomationParameters;
	
	public class UtopiaParameters extends DefaultAutomationParameters
	{
		public function UtopiaParameters()
		{
			super();
		}
		
		
		
		override protected function initSteps():void
		{
			_steps = new UtopiaStepsClasses();
		}
		
	}
}