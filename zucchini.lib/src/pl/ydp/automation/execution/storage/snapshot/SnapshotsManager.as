package pl.ydp.automation.execution.storage.snapshot
{
	import flash.display.BitmapData;
	import flash.events.EventDispatcher;
	
	import pl.ydp.automation.execution.storage.snapshot.algorithm.ComparisonAlgorithmSupplier;
	import pl.ydp.automation.execution.storage.snapshot.algorithm.ComparisonAlgorithmType;
	import pl.ydp.automation.execution.storage.snapshot.algorithm.IComparisonAlgorithm;

	/**
	 * Klasa dostarczająca narzędzi do analizy grafiki.
	 */
	public class SnapshotsManager extends EventDispatcher
	{
		[Inject]
		public var algorithmSupplier:ComparisonAlgorithmSupplier;
		
		public function SnapshotsManager()
		{
		}
		
		public function compare( bitmapDataA:BitmapData, bitmapDataB:BitmapData, algorithmType:String = ComparisonAlgorithmType.PIXEL_TO_PIXEL ):*
		{
			var algorithm:IComparisonAlgorithm = algorithmSupplier.getAlgorithm( algorithmType );
			var compareResult:* = algorithm.compare( bitmapDataA, bitmapDataB );
			return compareResult;
		}
	}
}