package pl.ydp.automation.execution.storage.snapshot
{
	import flash.events.Event;
	
	public class StorageSnapshotEvent extends Event
	{
		public static const LOADING_COMPLETE:String = 'snapshotLoadingComplete';
		public static const LOADING_FAIL:String = 'snapshotLoadingFail';
		
		public function StorageSnapshotEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}