package pl.ydp.automation.execution.structure
{
	import flash.events.Event;
	
	import org.osflash.signals.Signal;
	import org.osflash.signals.events.IEvent;

	public interface IStructureElementDescriptor
	{
		/**
		 * Returns iterable with children
		 */
		function get children():*;
		
		/**
		 * Get child by its id
		 */
		function getElementById( id:String ):*;
		
		/**
		 * Przekazyje event do wywołania
		 * na opisywanym elemencie struktury.
		 */
		function dispatchEventFromElement( event:Event ):void;
		
		function get stepCompleted():Signal;
	}
}