package pl.ydp.automation.execution.report
{
	import mockolate.strict;
	
	import org.flexunit.assertThat;
	import org.hamcrest.object.equalTo;
	import org.hamcrest.object.notNullValue;
	import pl.ydp.automation.execution.report.ReportData;

	public class TestReportData
	{		
		private var report:ReportData;
		private var reportXML:XML;
		
		[Before]
		public function setUp():void
		{
			reportXML = new XML( <testsuites><testsuite></testsuite></testsuites> );
			report = new ReportData( reportXML );
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[Test]
		public function should_create_script_report():void
		{
			assertThat( report, notNullValue() );
			assertThat( report.reportXML, equalTo( reportXML ) );
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