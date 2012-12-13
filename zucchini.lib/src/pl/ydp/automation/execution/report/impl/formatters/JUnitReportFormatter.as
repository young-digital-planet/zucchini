package pl.ydp.automation.execution.report.impl.formatters
{
	import pl.ydp.automation.execution.report.IReportFormatter;
	import pl.ydp.automation.execution.report.ReportData;
	
	public class JUnitReportFormatter implements IReportFormatter
	{
		
		
		public function JUnitReportFormatter()
		{
		}
		
		public function format( reportData:ReportData ):String
		{
			delete reportData.reportXML.testcase.teststep;
			
			return reportData.reportXML.toXMLString();
		}
		
	}
}