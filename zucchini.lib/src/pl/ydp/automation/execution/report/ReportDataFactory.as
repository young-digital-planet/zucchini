package pl.ydp.automation.execution.report
{
	import pl.ydp.automation.execution.AutomationScenario;
	import pl.ydp.automation.execution.AutomationScript;
	import pl.ydp.automation.execution.IAutomationStep;
	import pl.ydp.automation.scripts.steps.StepResult;

	/**
	 * Klasa odpowiedzialna za tworzenie modeli danych raporów
	 * oraz ich uzupełnianie o wyniki testów w czasie ich wykonywania.
	 */
	public class ReportDataFactory
	{
		
		public function ReportDataFactory()
		{
		}
		
		/**
		 * Stworzenie obiektu reprezentującego raport skryptu.
		 */
		public function createScriptReport( script:AutomationScript ):ReportData
		{
			var xml:XML = new XML( <testsuite></testsuite> );
			var scriptReport = new ReportData( xml, script.name );
			
			for each( var scenario:AutomationScenario in script.automationScenarios ){
				addScenario( scriptReport, scenario.name );
				
				for each( var step:IAutomationStep in scenario.steps ){
					addStep( scriptReport, scenario.name, step.name );
				}
			}
			return scriptReport;
		}
		
		/**
		 * Dodanie węzła reprezentuającego scenariusz do modelu
		 * przechowującego raport skryptu.
		 */
		public function addScenario( scriptReport:ReportData, scenarioName:String ):void
		{
			var scenarioXML:XML = new XML( <testcase></testcase> );
			scenarioXML.@classname = scriptReport.reportXML.@name;
			scenarioXML.@name = scenarioName;
			
			scriptReport.reportXML.appendChild( scenarioXML );
		}
		
		/**
		 * Dodanie węzła reprezentuającego krok do modelu
		 * przechowującego raport skryptu.
		 */
		public function addStep( scriptReport:ReportData, scenarioName:String, stepName:String ):void
		{
			var stepXML:XML = new XML( <teststep></teststep> );
			stepXML.@name = stepName;
			stepXML.@classname = scenarioName;
			
			var scenarioXML:XML = scriptReport.reportXML.testcase.(@name == scenarioName)[0] as XML;
			scenarioXML.appendChild( stepXML );
		}
		
		
		/**
		 * Uzupełnia obiekt raportu o wynik wykonania
		 * konrektnego kroku.
		 */
		public function addStepResult( report:ReportData, scenarioIndex:int, stepIndex:int, result:StepResult ):void
		{
			var scenarioXML:XML = report.reportXML.testcase[ scenarioIndex ] as XML;
			
//			zmiana statusu kroku
			var status:String = result.correctly ? 'passed' : 'failed';
			var stepXML:XML = scenarioXML.teststep[ stepIndex ] as XML;
			stepXML.@status = status;
			
			
			if( !result.correctly ){
//				dodanie węzła błędu
				var failureXML:XML = new XML( <failure></failure> );
				failureXML.@message = result.message;
				scenarioXML.appendChild( failureXML );
			}
		}
		
		
		public function finishReport( report:ReportData ):void
		{
				report.reportXML.@errors = ( report.reportXML.testcase.error as XMLList ).length();
				report.reportXML.@failures = ( report.reportXML.testcase.failure as XMLList ).length();
				report.reportXML.@tests = ( report.reportXML.testcase.teststep as XMLList ).length();
		}
		
	}
}