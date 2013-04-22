package pl.ydp.automation.execution.storage.snapshot.algorithm.impl
{
	import flash.display.BitmapData;
	import flash.events.Event;
	
	import mockolate.prepare;
	
	import org.flexunit.assertThat;
	import org.flexunit.async.Async;
	import org.hamcrest.object.equalTo;
	
	import pl.ydp.automation.execution.storage.snapshot.algorithm.IComparisonAlgorithm;

	[RunWith("org.flexunit.runners.Parameterized")]
	public class TestPixelToPixelComparisonAlgorithm
	{		
		private var pixelToPixelAlgorithm:IComparisonAlgorithm; 
		
//		format: [xA, yA, xB, yB, expectedDifferences]
		public static function bitmapsParameters():Array {
			return [ [10, 10, 10, 10, 0 ], [ 10, 10, 10, 11, 2 ] ];
		}
		
		[Before]
		public function setUp():void
		{
			pixelToPixelAlgorithm = new PixelToPixelComparisonAlgorithm();
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
			var differences:int = pixelToPixelAlgorithm.compare( bitmapDataA, bitmapDataB );
			
//			then
			assertThat( differences, equalTo( expectedDifferences ) );
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