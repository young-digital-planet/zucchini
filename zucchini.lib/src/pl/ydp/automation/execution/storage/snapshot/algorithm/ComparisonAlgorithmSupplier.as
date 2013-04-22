package pl.ydp.automation.execution.storage.snapshot.algorithm
{
	import flash.utils.Dictionary;
	
	import org.robotlegs.core.IInjector;
	
	import pl.ydp.automation.execution.storage.snapshot.algorithm.impl.HashComparisonAlgorithm;
	import pl.ydp.automation.execution.storage.snapshot.algorithm.impl.HistogramComparisonAlgorithm;
	import pl.ydp.automation.execution.storage.snapshot.algorithm.impl.PixelToPixelComparisonAlgorithm;

	public class ComparisonAlgorithmSupplier
	{
		[Inject]
		public var injector:IInjector;
		
		private var _map:Dictionary;
		
		public function ComparisonAlgorithmSupplier()
		{
			_map = new Dictionary();
			mapAlgorithms();
			mapSingletons();
		}
		
		private function mapAlgorithms():void
		{
			_map[ ComparisonAlgorithmType.PIXEL_TO_PIXEL ] = PixelToPixelComparisonAlgorithm;
			_map[ ComparisonAlgorithmType.HISTOGRAM ] = HistogramComparisonAlgorithm;
			_map[ ComparisonAlgorithmType.HASH ] = HashComparisonAlgorithm;
		};
		
		private function mapSingletons():void
		{
			for each( var algorithmClass:Class in _map ){
				injector.mapSingleton( algorithmClass );
			}
		}
		
		public function getAlgorithm( algorithmType:String ):IComparisonAlgorithm
		{
			var algorithmClass:Class = _map[algorithmType] as Class;
			var algorithm:IComparisonAlgorithm = injector.getInstance( algorithmClass );
			return algorithm;
		}
	}
}