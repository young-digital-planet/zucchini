package pl.ydp.automation.execution.report
{
	import flash.events.Event;
	
	import mockolate.mock;
	import mockolate.nice;
	import mockolate.prepare;
	import mockolate.strict;
	import mockolate.verify;
	
	import mx.effects.IAbstractEffect;
	
	import org.flexunit.assertThat;
	import org.flexunit.async.Async;
	import org.osflash.signals.utils.proceedOnSignal;
	
	import pl.ydp.automation.execution.AutomationScript;
	import pl.ydp.automation.scripts.ScriptsModel;
	import pl.ydp.automation.scripts.steps.StepResult;
	import pl.ydp.automation.execution.report.ReportData;
	import pl.ydp.automation.execution.report.ReportDataFactory;
	import pl.ydp.automation.execution.report.ReportExporter;
	import pl.ydp.automation.execution.report.ReportManager;

	public class TestReportManager
	{		
		private var reportManager:ReportManager;
		private var scriptReportFactory:ReportDataFactory;
		
		[Before]
		public function setUp():void
		{
			scriptReportFactory = strict( ReportDataFactory );
			
			reportManager = new ReportManager();
			reportManager.scriptReportFactory = scriptReportFactory;
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[Test]
		public function should_initialize_report():void
		{
//			given
			var script:AutomationScript = nice( AutomationScript );
			var scriptsModel:ScriptsModel = strict( ScriptsModel );
			mock( scriptsModel ).getter( 'scriptsToExecute' ).returns( [ script ] );
			mock( scriptReportFactory ).method( 'createScriptReport' ).once();
			
			reportManager.scriptsModel = scriptsModel;
			
//			when
			reportManager.initializeReport( 0 );
			
//			then
			verify( scriptReportFactory );
		}
		
		[Test]
		public function should_handle_step_result():void
		{
//			given
			var report:ReportData = new ReportData( new XML() );
			mock( scriptReportFactory ).method( 'addStepResult' ).once();
			var result:StepResult = nice( StepResult );
			
//			when
			reportManager.handleStepResult( 0, 0, result );
			
//			then
			verify( scriptReportFactory );
		}
		
		[Test]
		public function should_finish_report():void
		{
//			given
			var report:ReportData = nice( ReportData, null, [ new XML() ] );
			reportManager.currentReportData = report;
			
			mock( scriptReportFactory ).method( 'finishReport' ).once();
			
			var reportExporter:ReportExporter = strict( ReportExporter );
			mock( reportExporter ).method( 'handleReportData' ).once();
			reportManager.reportExporter = reportExporter;
			
//			when
			reportManager.finishReport();
			
//			then
			verify( scriptReportFactory );
			verify( reportExporter );
		}
		
		[Test(async)]
		public function should_dispatch_reports_exported_signal():void
		{
			var scriptsModel:ScriptsModel = strict( ScriptsModel );
			mock( scriptsModel ).getter( 'scriptsToExecute' ).returns( [ '' ] );
			
			var mockReportManager:ReportManager = strict( ReportManager );
			mock( mockReportManager ).getter( 'exportedReportsCount' ).returns( 1 );
			mock( mockReportManager ).getter( 'allReportsExported' ).callsSuper();
			mock( mockReportManager ).method( 'checkExportQueue' ).callsSuper();
			
			mockReportManager.scriptsModel = scriptsModel;
			
//			then
			proceedOnSignal( this, mockReportManager.allReportsExported, 100 );
			
//			when
			mockReportManager.checkExportQueue();
		}
		
		
		[BeforeClass(async, timeout=100)]
		public static function setUpBeforeClass():void
		{
			Async.proceedOnEvent(TestReportManager,
				prepare( 
					AutomationScript, 
					ScriptsModel, 
					ReportDataFactory, 
					ReportData,
					ReportExporter,
					StepResult,
					ReportManager),
				Event.COMPLETE);
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		
	}
}