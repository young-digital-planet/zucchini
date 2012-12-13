package pl.ydp.automation.scripts
{
	import flash.events.IEventDispatcher;

	public interface IScripts extends IEventDispatcher
	{
		function initialize():void;
		function getScriptSource( name:String ):IScriptSource;
		function get scripts():Object;
		function get scriptsCount():int;
	}
}