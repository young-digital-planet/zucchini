package pl.ydp.automation.execution.report
{
	public interface IReportFormatter
	{
		/**
		 * Konwersja modelu danych raportu do docelowego formatu.
		 */ 
		function format( reportData:ReportData ):String;
	}
}