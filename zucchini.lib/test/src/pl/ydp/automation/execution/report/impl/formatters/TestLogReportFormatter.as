package pl.ydp.automation.execution.report.impl.formatters
{
	import mockolate.mock;
	import mockolate.strict;
	
	import org.flexunit.assertThat;
	import org.hamcrest.object.equalTo;
	
	import pl.ydp.automation.execution.report.ReportData;

	public class TestLogReportFormatter
	{		
		private var logFormatter:LogReportFormatter;
		private var reportData:ReportData;
		
		private var INPUT_REPORT_XML:XML = new XML(
			<testsuites>
			  <testsuite name="checkCheckbox" errors="0" failures="1" tests="4">
				<testcase classname="checkCheckbox" name="check checkbox button 2">
				  <teststep name="loadLesson" classname="check checkbox button 2" status="passed"/>
				  <teststep name="selectButton" classname="check checkbox button 2" status="failed"/>
				  <failure message="Element not found"/>
				</testcase>
				<testcase classname="checkCheckbox" name="check checkbox button">
				  <teststep name="loadLesson" classname="check checkbox button" status="passed"/>
				  <teststep name="selectButton" classname="check checkbox button" status="passed"/>
				</testcase>
			  </testsuite>
			</testsuites>
		);
		
		private var OUTPUT_REPORT:String = '' +
			
			'\n-----REPORT START-----\n\n' +
			'SUITE:\n' +
			'\tFAILED - CASE: check checkbox button 2\n' +
			'\t\tOK - STEP: loadLesson\n' +
			'\t\tFAILED (Element not found) - STEP: selectButton\n' +
			'\tOK - CASE: check checkbox button\n' +
			'\t\tOK - STEP: loadLesson\n' +
			'\t\tOK - STEP: selectButton\n\n' +
			'-----REPORT END-----\n'
		;
		
		
		[Before]
		public function setUp():void
		{
			logFormatter = new LogReportFormatter();

			reportData = strict( ReportData, null, [ INPUT_REPORT_XML ,'' ] );
			mock( reportData ).getter( 'reportXML' ).callsSuper();
		}
		
		[After]
		public function tearDown():void
		{
		}
		
		[Test]
		public function should_format_reportdata():void
		{
//			when
			var report:String = logFormatter.format( reportData );
			
//			then
			assertThat( report, equalTo( OUTPUT_REPORT ) );
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