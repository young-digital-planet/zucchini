package pl.ydp.automation
{
	import org.osflash.signals.Signal;
	
	import pl.ydp.automation.execution.ExecutionManager;
	import pl.ydp.automation.execution.report.ReportExporter;
	import pl.ydp.automation.execution.report.ReportManager;

	/**
	 * Silnik odpowiedzialny za sterowanie wykonywaniem testów.
	 */
	public class ExecutionEngine
	{
		[Inject]
		public var executionManager:ExecutionManager;
		[Inject]
		public var reportManager:ReportManager;
		
		
		private var _executionCompleted:Signal = new Signal();
		
		
		public function ExecutionEngine()
		{
			
		}
		
		
		
		/**
		 * Rozpoczęcie procesu wykonania testów.
		 */
		public function start():void
		{
			reportManager.allReportsExported.add( onAllReportsExported );
			executionManager.allTestsCompleted.addOnce( onAllTestsCompleted );
			executionManager.start();
		}
		
		private function onAllTestsCompleted():void
		{
			_executionCompleted.dispatch();
		}
		
		private function onAllReportsExported():void
		{
		}
		

		public function get executionCompleted():Signal
		{
			return _executionCompleted;
		}
		

	}
}