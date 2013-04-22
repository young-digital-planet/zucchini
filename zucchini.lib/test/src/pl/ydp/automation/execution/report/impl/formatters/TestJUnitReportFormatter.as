package pl.ydp.automation.execution.report.impl.formatters
{
	import flash.events.Event;
	
	import mockolate.mock;
	import mockolate.prepare;
	import mockolate.strict;
	
	import org.flexunit.assertThat;
	import org.flexunit.async.Async;
	import org.hamcrest.object.equalTo;
	
	import pl.ydp.automation.execution.report.ReportData;

	public class TestJUnitReportFormatter
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
		public function setUp():void
		{
			jUnitFormatter = new JUnitReportFormatter();
			
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
			var report:String = jUnitFormatter.format( reportData );
			
//			then
			assertThat( report, equalTo( OUTPUT_REPORT_XML.toXMLString() ) );
		}
		
		[BeforeClass(async, timeout=100)]
		public static function setUpBeforeClass():void
		{
			Async.proceedOnEvent(TestJUnitReportFormatter,
				prepare( ReportData ),
				Event.COMPLETE);
		}
		
		[AfterClass]
		public static function tearDownAfterClass():void
		{
		}
		
		
	}
}