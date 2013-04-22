package pl.ydp.automation.execution.storage.snapshot.algorithm.impl
{
	import flash.display.BitmapData;
	
	import pl.ydp.automation.execution.storage.snapshot.algorithm.IComparisonAlgorithm;
	

	public class HistogramComparisonAlgorithm implements IComparisonAlgorithm
	{
		public function HistogramComparisonAlgorithm()
		{
		}
		
		public function compare(firstBitmap:BitmapData, secondBitmap:BitmapData):* {
			var firstAvColor:uint = histogramTest(firstBitmap);
			var secondAvColor:uint = histogramTest(secondBitmap); 
			var percentage:Number = Math.abs(firstAvColor - secondAvColor) * 100 / Math.max(firstAvColor, secondAvColor);
			return percentage;
		}
		
		private function histogramTest(source:BitmapData):uint {
			var histogram:Vector.<Vector.<Number>> = source.histogram();
			
			var red:Number = 0;
			var green:Number = 0;
			var blue:Number = 0;
			
			var width:uint = source.width;
			var height:uint = source.height;
			var countInverse:Number = 1 / (width*height);
			
			for (var i:int = 0; i < 256; ++i) {
				red += i * histogram[0][i];
				green += i * histogram[1][i];
				blue += i * histogram[2][i];
			}
			
			red *= countInverse;
			green *= countInverse;
			blue *= countInverse;
			
			var rgb:uint = red << 16 | green << 8 | blue;
			return rgb;
		}
	}
}