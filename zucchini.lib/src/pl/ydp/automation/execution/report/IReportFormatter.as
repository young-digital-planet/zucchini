package pl.ydp.automation.execution.report
{
	public interface IReportFormatter
	{
		function format( reportData:ReportData ):String;
	}
}