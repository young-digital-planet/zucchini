package pl.ydp.automation.execution.report.impl.targets
{
	import com.carlcalderon.arthropod.Debug;
	
	import flash.utils.setTimeout;
	
	import org.osflash.signals.Signal;
	
	import pl.ydp.automation.execution.report.IReportTarget;
	
	public class ArthropodReportTarget implements IReportTarget
	{
		public function ArthropodReportTarget()
		{
		}
		
		public function send(scriptName:String, report:String):Signal
		{
			var signal:Signal = new Signal();
			
			Debug.log( report );
			
			setTimeout( signal.dispatch, 0 );
			return signal;
		}
	}
}