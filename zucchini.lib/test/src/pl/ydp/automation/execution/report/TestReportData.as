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
		private var SCRIPT_NAME:String = 'scriptName';
		private var reportXML:XML;
		
		[Before]
		public function setUp():void
		{
			reportXML = new XML( <testsuites><testsuite></testsuite></testsuites> );
			report = new ReportData( reportXML, SCRIPT_NAME );
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
			assertThat( report.reportXML.testsuite.@name, equalTo( SCRIPT_NAME ) );
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