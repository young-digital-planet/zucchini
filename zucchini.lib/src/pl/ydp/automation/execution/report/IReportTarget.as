package pl.ydp.automation.execution.report
{
	import org.osflash.signals.Signal;

	public interface IReportTarget
	{
		function send( scriptName:String, report:String ):Signal;
	}
}