package pl.ydp.automation.scripts
{
	import flash.events.IEventDispatcher;
	import flash.utils.ByteArray;
	
	import pl.ydp.automation.execution.AutomationScript;

	/**
	 * Reprezentuje źródło, które ładuje script
	 */
	[Event(name="complete")]
	public interface IScriptSource extends IEventDispatcher
	{
		function load():void;
		function get name():String;
		function get script():AutomationScript;
		function get content():String;
	}
}