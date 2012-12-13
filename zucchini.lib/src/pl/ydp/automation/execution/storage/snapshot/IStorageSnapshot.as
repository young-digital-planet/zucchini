package pl.ydp.automation.execution.storage.snapshot
{
	import flash.display.BitmapData;

	public interface IStorageSnapshot
	{
		function get id():*;
		
		/**
		 * Zwraca identyfikator kontentu (IStorageContent), 
		 * na którym został stworzony.
		 */
		function get sourceContentId():*;

		function get bitmapData():BitmapData;
		
			
	}
}