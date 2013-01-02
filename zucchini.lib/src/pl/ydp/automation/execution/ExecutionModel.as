package pl.ydp.automation.execution
{
	/**
	 * Model danych przechowujący konfigurację wykonywania testów.
	 */
	public class ExecutionModel
	{
		public static const NORMAL_EXECUTION:String = 'normalExecution';
		public static const SLOW_EXECUTION:String = 'slowExecution';
		
		/**
		 * Odstęp czasu między wykonaniem kolejnych kroków wyrażony w milisekundach.
		 * Nadaje sens oglądaniu wykonanywania testów przez testera,
		 * (bez interwału nie wszystkie efekty kroków jesteśmy
		 * w stanie dostrzec, gdyż wykonują się zbyt szybko).
		 */
		private var _stepsInterval:int = 0;
		
		public function ExecutionModel()
		{
		}

		public function get executionMode():String
		{
			if( _stepsInterval == 0){
				return NORMAL_EXECUTION;
			}
			return SLOW_EXECUTION;
		}

		

		public function get stepsInterval():int
		{
			return _stepsInterval;
		}

		public function set stepsInterval(value:int):void
		{
			if( value >= 0 ){
				_stepsInterval = value;
			}
		}


	}
}