package pl.ydp.automation.execution
{
	import pl.ydp.automation.execution.async.IAsyncWait;

	public interface IAutomationContext
	{
		function get root():*;
		function findObject( objectPath:String ):*;
		
		function addAsyncWait( description:String ):IAsyncWait;
	}
}