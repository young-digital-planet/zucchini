package pl.ydp.automation.execution.report.impl.formatters
{
	import flash.events.Event;
	
	import mockolate.prepare;
	
	import org.flexunit.async.Async;
	
	import pl.ydp.automation.execution.report.ReportData;

	public class TestJUnitReportFormatter extends AbstractTestReportFormatter
	{		
		private var jUnitFormatter:JUnitReportFormatter;
		private var reportData:ReportData;
		
		private var INPUT_REPORT_XML:XML = new XML(
			<testsuites>
				<testsuite>
					<testcase/>
					<testcase>
						<teststep/>
						<teststep/>
					</testcase>
					<testcase>
						<teststep/>
					</testcase>
				</testsuite>
			</testsuites>
		);
		
		private var OUTPUT_REPORT_XML:XML = new XML(
			<testsuites>
				<testsuite name="">
					<testcase/>
					<testcase/>
					<testcase/>
				</testsuite>
			</testsuites>
		);
		
		[Before]
		override public function setUp():void
		{
			setTestData( 
				new JUnitReportFormatter(), 
				INPUT_REPORT_XML, 
				OUTPUT_REPORT_XML.toXMLString() 
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
			Async.proceedOnEvent(TestJUnitReportFormatter,
				prepare( ReportData ),
				Event.COMPLETE);
		}
	}
}