package pl.ydp.automation.execution.storage.snapshot
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.IBitmapDrawable;
	import flash.events.Event;
	import flash.utils.ByteArray;
	
	import mockolate.mock;
	import mockolate.prepare;
	import mockolate.strict;
	
	import org.flexunit.assertThat;
	import org.flexunit.async.Async;
	import org.hamcrest.core.isA;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.notNullValue;
	
	import pl.ydp.automation.execution.structure.IStructure;
	import pl.ydp.automation.execution.storage.snapshot.SnapshotsManager;
	import pl.ydp.automation.execution.storage.snapshot.SnapshotsModel;

	[RunWith("org.flexunit.runners.Parameterized")]
	public class TestSnapshotsManager
	{		
		
		private var snapshotsModel:SnapshotsModel;
		private var snapshotManager:SnapshotsManager;
		
		
//		format: [xA, yA, xB, yB, expectedDifferences]
		public static function bitmapsParameters():Array {
			return [ [10, 10, 10, 10, 0 ], [ 10, 10, 10, 11, 2 ] ];
		}
		
		[Before]
		public function setUp():void
		{
			snapshotManager = new SnapshotsManager();
			snapshotsModel = new SnapshotsModel();
			snapshotManager.snapshotsModel = snapshotsModel;
		}
		
		
		[After]
		public function tearDown():void
		{
		}
		
		
		[Test(dataProvider="bitmapsParameters")]
		public function should_get_different_pixels_count( xA:int, yA:int, xB:int, yB:int, expectedDifferences:int ):void
		{
//			given
			var bitmapDataA:BitmapData = new BitmapData( 100, 100 );
			var bitmapDataB:BitmapData = new BitmapData( 100, 100 );
			
			bitmapDataA.setPixel32( xA, yA, 0xFF000000);  
			bitmapDataB.setPixel32( xB, yB, 0xFF000000);  
			
//			when
			var differences:int = snapshotManager.compare( bitmapDataA, bitmapDataB );
			
//			then
			assertThat( differences, equalTo( expectedDifferences ) );
		}
		
		
		[BeforeClass(async, timeout=100)]
		public static function setUpBeforeClass():void
		{
			Async.proceedOnEvent(TestSnapshotsManager,
				prepare( IStructure ),
				Event.COMPLETE);
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		
	}
}