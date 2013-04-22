package pl.ydp.automation.execution.storage.snapshot.algorithm
{
	import flash.display.BitmapData;

	public interface IComparisonAlgorithm
	{
		function compare( bitmapDataA:BitmapData, bitmapDataB:BitmapData ):*;
	}
}