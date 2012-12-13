package pl.ydp.automation.execution.storage.snapshot.impl
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.utils.ByteArray;
	
	import pl.ydp.automation.execution.storage.snapshot.IStorageSnapshot;

	public class UtopiaSnapshot implements IStorageSnapshot
	{
		private var _bitmap:Bitmap;
		
		public function UtopiaSnapshot( bitmap:Bitmap )
		{
			_bitmap = bitmap;
		}

		
		
		public function get sourceContentId():*
		{
			// TODO Auto Generated method stub
			return null;
		}
		
		public function get bitmapData():BitmapData
		{
			return _bitmap.bitmapData;
		}
		
		public function get id():*
		{
			// TODO Auto Generated method stub
			return null;
		}
		
	}
}