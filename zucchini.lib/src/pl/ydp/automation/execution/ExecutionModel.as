package pl.ydp.automation.execution
{
	public class ExecutionModel
	{
		public static const NORMAL_EXECUTION:String = 'normalExecution';
		public static const SLOW_EXECUTION:String = 'slowExecution';
		
		private var _stepsInterval:int = 1000;
		
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