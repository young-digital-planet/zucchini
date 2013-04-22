package pl.ydp.automation.execution.report.impl.formatters
{
	import flash.events.Event;
	
	import mockolate.prepare;
	
	import org.flexunit.async.Async;
	
	import pl.ydp.automation.execution.report.ReportData;

	public class TestLogReportFormatter extends AbstractTestReportFormatter
	{		
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
		override public function setUp():void
		{
			setTestData( 
				new LogReportFormatter(), 
				INPUT_REPORT_XML, 
				OUTPUT_REPORT 
			);
			super.setUp();
		}
		
		[Test]
		override public function should_format_reportdata():void
		{
			super.should_format_reportdata();
		}
		
		[BeforeClass(async, timeout=100)]
		public static function setUpBeforeClass():void
		{
			Async.proceedOnEvent(TestLogReportFormatter,
				prepare( ReportData ),
				Event.COMPLETE);
		}
	}
}