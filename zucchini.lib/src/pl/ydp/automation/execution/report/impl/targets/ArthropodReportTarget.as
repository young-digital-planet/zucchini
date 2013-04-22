package pl.ydp.automation.execution.report.impl.targets
{
	import com.carlcalderon.arthropod.Debug;
	
	import flash.utils.setTimeout;
	
	import org.osflash.signals.Signal;
	
	import pl.ydp.automation.execution.report.IReportTarget;
	import pl.ydp.utils.functions.getSignalAndDispatch;
	
	public class ArthropodReportTarget implements IReportTarget
	{
		public function ArthropodReportTarget()
		{
		}
		
		public function send(scriptName:String, report:String):Signal
		{
			Debug.log( report );
			
			return getSignalAndDispatch();
		}
	}
}