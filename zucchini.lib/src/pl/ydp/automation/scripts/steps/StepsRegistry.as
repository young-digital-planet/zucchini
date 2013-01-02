package pl.ydp.automation.scripts.steps
{
	/**
	 * Model danych przechowujących klasy kroków 
	 * dostępnych z obiektu po nazwie.
	 */
	public class StepsRegistry
	{
		[Inject]
		public var stepsClasses:IStepsClasses;
		
		private var _steps:Object = {};
		
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

		public function get steps():Object
		{
			return _steps;
		}

	}
}