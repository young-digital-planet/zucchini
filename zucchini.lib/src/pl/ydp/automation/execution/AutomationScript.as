package pl.ydp.automation.execution
{
	import pl.ydp.automation.scripts.parser.vo.IFeature;

	public class AutomationScript
	{	
		private var _feature:IFeature;
		
		private var _automationScenarios:Array = [];
		
		public function AutomationScript()
		{
		}
		

		public function get feature():IFeature
		{
			return _feature;
		}

		public function set feature(value:IFeature):void
		{
			_feature = value;
		}
		
		public function get name():String
		{
			return _feature.name;
		}

		public function get automationScenarios():Array
		{
			return _automationScenarios;
		}

		public function addAutomationScenario( automationScenario:AutomationScenario ):void
		{
			_automationScenarios.push( automationScenario );
		}
		
		

	}
}