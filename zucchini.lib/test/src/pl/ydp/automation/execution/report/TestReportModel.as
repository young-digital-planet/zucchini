package pl.ydp.automation.execution.report
{
	import org.flexunit.assertThat;
	import org.hamcrest.core.isA;
	import org.hamcrest.object.notNullValue;
	import pl.ydp.automation.execution.report.ReportData;
	import pl.ydp.automation.execution.report.ReportModel;

	public class TestReportModel
	{		
		private var reportModel:ReportModel;
		private var report:ReportData;
		
		[Before]
		public function setUp():void
		{
			reportModel = new ReportModel();
			report = new ReportData( new XML() );
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[Test]
		public function should_add_script():void
		{
//			when
			reportModel.addReportData( report );
			
//			then
			assertThat( reportModel.reportsData[ 0 ], notNullValue() );
			assertThat( reportModel.reportsData[ 0 ], isA( ReportData ) );
		}
		
		
		[BeforeClass]
		public static function setUpBeforeClass():void
		{
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		
	}
}