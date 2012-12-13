package pl.ydp.automation.execution.report
{
	import flash.events.Event;
	
	import mockolate.mock;
	import mockolate.nice;
	import mockolate.prepare;
	import mockolate.strict;
	import mockolate.verify;
	
	import org.flexunit.assertThat;
	import org.flexunit.async.Async;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.notNullValue;
	import org.osflash.signals.Signal;
	import org.osflash.signals.utils.proceedOnSignal;
	import org.robotlegs.core.IInjector;
	import pl.ydp.automation.execution.report.IReportFormatter;
	import pl.ydp.automation.execution.report.IReportTarget;
	import pl.ydp.automation.execution.report.ReportData;
	import pl.ydp.automation.execution.report.ReportExporter;
	import pl.ydp.automation.execution.report.ReportModel;

	public class TestReportExporter
	{		
		
		private var reportExporter:ReportExporter;
		private var reportModel:ReportModel;
		private var reportData:ReportData;
		private var injector:IInjector;
		
		
		[Before]
		public function setUp():void
		{
			reportData = nice( ReportData, null, [ new XML(), '' ] )
			reportModel = strict( ReportModel );
			injector = nice( IInjector );
			
			reportExporter = new ReportExporter();
			reportExporter.reportModel = reportModel;
			reportExporter.injector = injector;
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[Test]
		public function should_add_reportdata_to_model():void
		{
//			given
			mock( reportModel ).getter( 'instantExport' ).returns( false );
			mock( reportModel ).getter( 'reportsData' ).callsSuper();
			mock( reportModel ).method( 'addReportData' ).callsSuper();
			
			
//			when
			reportExporter.handleReportData( reportData );
			
//			then
			assertThat( reportModel.reportsData, notNullValue() );
			assertThat( reportModel.reportsData.length, equalTo( 1 ) );
			assertThat( reportModel.reportsData[0], equalTo( reportData ) );
		}
		
		[Test(async)]
		public function should_export_report():void
		{
//			given
			var reportFormatter:IReportFormatter = strict( IReportFormatter );
			mock( reportFormatter ).method( 'format' ).returns( 'report' ).once();
			
			var signal:Signal = new Signal();
			
			var reportTarget:IReportTarget = strict( IReportTarget );
			mock( reportTarget ).method( 'send' ).returns( signal ).once();
			
			mock( reportModel ).getter( 'reportsFormatters' ).returns( [ reportFormatter ] );
			mock( reportModel ).getter( 'reportsTargets' ).returns( [ reportTarget ] );
			
			mock( reportData ).getter( 'reportXML' ).returns( new XML(<root name="name"></root>) );
			
//			then
			proceedOnSignal( this, reportExporter.reportExported, 100 );
			
//			when
			reportExporter.exportReport( reportData );
			signal.dispatch();
			
//			then
			verify( reportFormatter );
			verify( reportTarget );
		}
		
		[Test]
		public function should_export_reports():void
		{
//			given
			mock( reportModel ).getter( 'instantExport' ).returns( false ).once();
			mock( reportModel ).getter( 'reportsData' ).returns( [] ).once();
			
//			when
			reportExporter.exportReports();
			
//			then
			verify( reportModel );
		}
		
		
		[BeforeClass(async, timeout=100)]
		public static function setUpBeforeClass():void
		{
			Async.proceedOnEvent(TestReportExporter,
				prepare( 
					IReportFormatter, 
					IReportTarget, 
					ReportData, 
					ReportModel),
				Event.COMPLETE);
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		
	}
}