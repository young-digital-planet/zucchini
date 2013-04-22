package pl.ydp.automation.execution.storage.snapshot.algorithm.impl
{
	import flash.display.BitmapData;
	import pl.ydp.automation.execution.storage.snapshot.algorithm.IComparisonAlgorithm;

	public class PixelToPixelComparisonAlgorithm implements IComparisonAlgorithm
	{
		public function PixelToPixelComparisonAlgorithm()
		{
		}
		
		/**
		 * Funkcja porównująca 2 grafiki
		 * 
		 * @return Liczba pikseli rózniących 2 grafiki
		 * <code>0</code> - obie grafiki są identyczne
		 */
		public function compare( bitmapDataA:BitmapData, 
								 bitmapDataB:BitmapData ):*
		{
			var compareResult = bitmapDataA.compare( bitmapDataB )
			var diffsCount:int;
			
			if( !(compareResult is BitmapData) ){
				diffsCount = 0;
			}else{
				diffsCount = getNonTransparentPixelsNo( compareResult );
			}
			return diffsCount;
		}
		
		/**
		 * Zwraca liczbę nieprzezroczystych pikseli 
		 * (np. dla argumentu, którym jest wynik porównania 2 bitmap,
		 * będzie to wartość oznaczająca liczbę pikseli, które różnią obie grafiki)
		 */
		private function getNonTransparentPixelsNo( bitmapData:BitmapData ):int
		{
			var pixelsCounter:int = 0;
			
			for( var x:int=0; x < bitmapData.width; x++ ){
				
				for( var y:int=0; y < bitmapData.height; y++ ){
					
					var pixelValue:uint = bitmapData.getPixel32( x, y );
					var alphaValue:uint = pixelValue >> 24 & 0xFF;
					
					if( alphaValue != 0 ){
						pixelsCounter++;
					}
				}
			}
			return pixelsCounter;
		}
	}
}