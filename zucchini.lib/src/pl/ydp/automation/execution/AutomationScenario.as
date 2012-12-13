package pl.ydp.automation.execution
{

	public class AutomationScenario
	{
		private var _name:String;
		private var _steps:Array = [];
		
		public function AutomationScenario( name:String )
		{
			_name = name;
		}
		
		
		
		public function addStep( step:IAutomationStep ):void
		{
			_steps.push( step );
		}

		public function get steps():Array
		{
			return _steps;
		}

		public function get name():String
		{
			return _name;
		}
		
		
	}
}