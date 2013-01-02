package pl.ydp.automation.configuration
{
	import flash.system.Capabilities;

	/**
	 * Model danych środowiska aplikacji oraz wykonywania testów.
	 */
	public class EnvironmentModel
	{
		public static const FF_WRAPPER:String = 'ff';
		public static const IE_WRAPPER:String = 'ie';
		public static const INTERNAL_WRAPPER:String = 'internal';
		
		private const BROWSERS_DIR_NAME:String = 'browsers';
		
		private var _executionWrapper:String = INTERNAL_WRAPPER;
		private var _filesystemDelimiter:String = '/';
		
		
		
		public function EnvironmentModel()
		{
			initDelimiter();
		}
		
		/**
		 * Wykrycie slash/backslash na podstawie systemu operacyjnego.
		 */
		internal function initDelimiter():void
		{
			if( Capabilities.os.indexOf( 'Windows' ) >=0 ){
				_filesystemDelimiter = '\\';
			}else{
				_filesystemDelimiter = '/';
			}
		}
		
		/**
		 * Fragment ścieżki determinowany środowiskiem wykonania.
		 */
		public function get wrapperDirName():String
		{
			var path:String;
			if( _executionWrapper == EnvironmentModel.INTERNAL_WRAPPER ){
				path = INTERNAL_WRAPPER;
			}else{
				path = BROWSERS_DIR_NAME + filesystemDelimiter + _executionWrapper;
			}
			return path;
		}
		
		
		public function get executionWrapper():String
		{
			return _executionWrapper;
		}

		public function set executionWrapper(value:String):void
		{
			_executionWrapper = value;
		}

		public function get filesystemDelimiter():String
		{
			return _filesystemDelimiter;
		}
		
		
		

	}
}