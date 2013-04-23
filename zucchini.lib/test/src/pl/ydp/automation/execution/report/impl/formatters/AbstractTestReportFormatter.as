package pl.ydp.automation.execution.report.impl.formatters
{
	import mockolate.mock;
	import mockolate.strict;
	
	import org.flexunit.assertThat;
	import org.hamcrest.object.equalTo;
	
	import pl.ydp.automation.execution.report.IReportFormatter;
	import pl.ydp.automation.execution.report.ReportData;

	public class AbstractTestReportFormatter
	{
		private var reportFormatter:IReportFormatter;
		private var reportData:ReportData;
		
		private var inputReportXML:XML;
		private var outputReport:String;
		
		public function setUp():void
		{
			reportData = strict( ReportData, null, [ inputReportXML ] );
			mock( reportData ).getter( 'reportXML' ).callsSuper();
		}
		
		protected function setTestData( formatter:IReportFormatter, input:XML, output:String ):void
		{
			reportFormatter = formatter;
			inputReportXML = input;
			outputReport = output;
		}
		
		public function should_format_reportdata():void
		{
//			when
			var report:String = reportFormatter.format( reportData );
			
//			then
			assertThat( report, equalTo( outputReport ) );
		}
		
	}
}