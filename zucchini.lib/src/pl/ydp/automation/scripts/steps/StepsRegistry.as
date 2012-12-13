package pl.ydp.automation.scripts.steps
{
	
	public class StepsRegistry
	{
		[Inject]
		public var stepsClasses:IStepsClasses;
		
		private var _steps:* = {};
		
		public function StepsRegistry()
		{
		}

		[PostConstruct]
		public function registerSteps():void 
		{
			for each (var stepClass:Class in stepsClasses.classes){
				registerStep(stepClass);
			}
		}
		
		public function registerStep(stepClass:Class):void
		{
			_steps[stepClass.NAME] = stepClass;
		}

		public function get steps():*
		{
			return _steps;
		}

		public function getStep( stepName:String ):String
		{
			if( _steps.hasOwnProperty( stepName ) ){
				return steps[stepName];
			}
			return null;
		}
	}
}