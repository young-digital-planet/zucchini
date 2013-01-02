package pl.ydp.automation.execution.report
{
	import org.osflash.signals.Signal;
	
	import pl.ydp.automation.execution.AutomationScript;
	import pl.ydp.automation.execution.ExecutionManager;
	import pl.ydp.automation.scripts.ScriptsModel;
	import pl.ydp.automation.scripts.steps.StepResult;

	/**
	 * Klasa odpowiedzialna za zarządzanie procesem 
	 * powstawania i exportu raportów.
	 */
	public class ReportManager
	{
		[Inject]
		public var scriptsModel:ScriptsModel;
		[Inject]
		public var scriptReportFactory:ReportDataFactory;
		[Inject]
		public var executionManager:ExecutionManager;
		[Inject]
		public var reportExporter:ReportExporter;
		
		private var _currentReportData:ReportData;
		
		private var _allReportsExported:Signal = new Signal();
		
		private var _exportedReportsCount:int;
		
		/**
		 * Zarządza obsługą modelu danych raportu.
		 */
		public function ReportManager()
		{
			
		}
		
		[PostConstruct]
		public function postConstructOperations():void
		{
			addListeners();
		}
		
		private function addListeners():void
		{
			executionManager.executionStarted.add( onExecutionStarted );
			
			executionManager.scriptStarted.add( onScriptStarted );
			executionManager.scenarioStarted.add( onScenarioStarted );
			executionManager.stepStarted.add( onStepStarted );
			executionManager.stepFinished.add( onStepFinished );
			executionManager.scenarioFinished.add( onScenarioFinished );
			executionManager.scriptFinished.add( onScriptFinished );
			
			executionManager.allTestsCompleted.add( onAllTestCompleted );
			
			reportExporter.reportExported.add( onReportExported );
			
		}
		
		private function onExecutionStarted():void
		{
			_exportedReportsCount = 0;
		}
		
		private function onScriptStarted():void
		{
			initializeReport( executionManager.currentScriptIndex );
		}
		private function onScenarioStarted():void{}
		
		private function onStepStarted():void{}
		
		private function onStepFinished( result:StepResult ):void
		{
			handleStepResult( executionManager.currentScenarioIndex, executionManager.currentStepIndex, result );
		}
		
		private function onScenarioFinished():void{}
		
		private function onScriptFinished():void
		{
			finishReport();
		}
		
		
		private function onAllTestCompleted():void
		{
			exportReports();
		}
		
		private function onReportExported():void
		{
			_exportedReportsCount++;
			checkExportQueue();
		}
		
		internal function checkExportQueue():void
		{
			if( exportedReportsCount == scriptsModel.scriptsToExecute.length ){
				_allReportsExported.dispatch();
			}
		}
		
		/**
		 * Przygotowanie modelu (XML) raportu na podstawie
		 * skryptu (AutomationScript). 
		 */
		internal function initializeReport( scriptIndex:int ):void
		{
			var script:AutomationScript = scriptsModel.scriptsToExecute[ scriptIndex ];
			var reportData:ReportData = scriptReportFactory.createScriptReport( script );
			_currentReportData = reportData;
		}
		
		/**
		 * Obsługa zakończenia wykonania kroku scenariusza.
		 */
		internal function handleStepResult( scenarioIndex:int, stepIndex:int, result:StepResult ):void
		{
			scriptReportFactory.addStepResult( _currentReportData, scenarioIndex, stepIndex, result );
		}
		
		/**
		 * Uzupełnienie brakujących atrybutów raportu.
		 */
		internal function finishReport():void
		{
			scriptReportFactory.finishReport( _currentReportData );
			reportExporter.handleReportData( _currentReportData );
		}
		
		internal function exportReports():void
		{
			reportExporter.exportReports();
		}

		internal function set currentReportData( value:ReportData):void
		{
			_currentReportData = value;
		}

		public function get allReportsExported():Signal
		{
			return _allReportsExported;
		}

		public function get exportedReportsCount():int
		{
			return _exportedReportsCount;
		}

		
	}
}