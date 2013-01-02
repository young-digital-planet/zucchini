package pl.ydp.automation.execution.storage.snapshot
{
	/**
	 * Model danych przechowujący informację o konfiguracji
	 * wykonywania snapshotów.
	 */
	public class SnapshotsModel
	{
		/**
		 * Tryb pobierania i zapisu wzorcowego snapshota dla widoku.
		 */
		public static const PATTERN_MODE:String = 'patternMode';
		/**
		 * Tryb porównywania aktualnego widoku z dostępnym wzorcem.
		 */
		public static const COMPARE_MODE:String = 'compareMode';

		/**
		 * Tryb wykonywania snapshotów.
		 * Dostępne opcje: <code>patternMode, compareMode</code>.
		 * Domyślnie: <code>compareMode</code>.
		 */
		private var _mode:String = COMPARE_MODE;
		
		public function SnapshotsModel()
		{
		}
		

		public function get mode():String
		{
			return _mode;
		}

		public function set mode(value:String):void
		{
			_mode = value;
		}
		
		
		
	}
}