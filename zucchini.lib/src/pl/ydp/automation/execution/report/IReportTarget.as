package pl.ydp.automation.execution.report
{
	import org.osflash.signals.Signal;

	/**
	 * API punktu docelowego raportów.
	 */
 	public interface IReportTarget
	{
		/**
		 * Wysłanie sformatowanego raportu.
		 * @param scriptName Nazwa skryptu
		 * @param report ostateczna forma raportu
		 */
		function send( scriptName:String, report:String ):Signal;
	}
}