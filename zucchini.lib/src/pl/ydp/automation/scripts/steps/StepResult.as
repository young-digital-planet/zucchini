package pl.ydp.automation.scripts.steps
{
	
	/**
	 * Reprezentacja wyniku wykonania kroku.
	 */
	public class StepResult
	{
		private var _correctly:Boolean;
		private var _message:String;
		private var _error:Error;
		private var _time:int;
		
		public function StepResult( correctly:Boolean = false )
		{
			_correctly = correctly;
		}

		public function get correctly():Boolean
		{
			return _correctly;
		}

		public function set correctly(value:Boolean):void
		{
			_correctly = value;
		}

		public function get message():String
		{
			return _message;
		}

		public function set message(value:String):void
		{
			_message = value;
		}

		public function get error():Error
		{
			return _error;
		}

		public function set error(value:Error):void
		{
			_error = value;
		}

		public function get time():int
		{
			return _time;
		}

		public function set time(value:int):void
		{
			_time = value;
		}


	}
}