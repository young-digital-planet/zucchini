package pl.ydp.automation.execution.storage.snapshot.impl
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	import org.flexunit.assertThat;
	import org.hamcrest.core.isA;
	
	import pl.ydp.automation.execution.storage.snapshot.IStorageSnapshot;
	import pl.ydp.automation.execution.storage.snapshot.impl.UtopiaSnapshot;

	public class TestUtopiaSnapshot
	{	
		
		private var utopiaSnapshot:IStorageSnapshot;
		
		[Before]
		public function setUp():void
		{
			var bitmapData:BitmapData = new BitmapData( 100, 100 );
			var bitmap:Bitmap = new Bitmap( bitmapData );
			utopiaSnapshot = new UtopiaSnapshot( bitmap );
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[Test]
		public function should_get_bitmap_data_from_snapshot():void
		{
			assertThat( utopiaSnapshot.bitmapData, isA( BitmapData ) );
		}
		
		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		
	}
}