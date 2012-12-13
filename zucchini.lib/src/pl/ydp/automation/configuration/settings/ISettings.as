package pl.ydp.automation.configuration.settings
{
	import org.hamcrest.collection.array;

	public interface ISettings
	{
		function get scriptsToPrepareNames():Array;
		function get scriptsToExecuteNames():Array;
		function get reportsTargets():Array;
		function get reportsFormatters():Array;
		function get snapshotMode():String;
		function get executionWrapper():String;
		function get stepsInterval():int;
	}
}