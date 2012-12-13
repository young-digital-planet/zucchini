package pl.ydp.automation.execution.storage.snapshot
{
	public class SnapshotsModel
	{
		private var _snapshots:Array = [];
		private var _mode:String = COMPARE_MODE;
		
		public static const PATTERN_MODE:String = 'patternMode';
		public static const COMPARE_MODE:String = 'compareMode';
		
		public function SnapshotsModel()
		{
		}
		
		public function addSnapshot( snapshot:IStorageSnapshot ):void
		{
			_snapshots.push( snapshot );
		}

		public function get snapshots():Array
		{
			return _snapshots;
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