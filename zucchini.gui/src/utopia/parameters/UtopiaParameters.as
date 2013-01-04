package utopia.parameters
{
	import pl.ydp.automation.configuration.impl.parameters.DefaultAutomationParameters;
	
	import utopia.structure.UtopiaStructure;
	import utopia.structure.UtopiaStructureComponent;
	
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
		
		override protected function initStructure():void
		{
			_structure = new UtopiaStructure();
		}
		
	}
}