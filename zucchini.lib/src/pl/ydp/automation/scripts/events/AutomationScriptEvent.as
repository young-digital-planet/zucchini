package pl.ydp.automation.scripts.events
{
	import flash.events.Event;
	
	import pl.ydp.automation.execution.AutomationScript;
	
	public class AutomationScriptEvent extends Event
	{
		public static const COMPLETE:String = 'automationScriptComplete';
		
		private var _automationScript:AutomationScript; 
		
		public function AutomationScriptEvent(type:String, automationScript:AutomationScript, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_automationScript = automationScript;
		}

		public function get automationScript():AutomationScript
		{
			return _automationScript;
		}

	}
}