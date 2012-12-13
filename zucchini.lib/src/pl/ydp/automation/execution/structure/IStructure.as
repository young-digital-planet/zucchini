package pl.ydp.automation.execution.structure
{
	import flash.display.IBitmapDrawable;
	import flash.events.Event;
	
	import pl.ydp.p2.IModule;

	public interface IStructure
	{
		function get rootItem():*;
		
		/**
		 * Daje dostęp do poszczególnych elementów struktury.
		 * @param elementId identyfikator elementu
		 * @return obiekt opisujący element struktury
		 */
		function getElementDescriptor( elementId:String ):IStructureElementDescriptor;
		function getElement( elementIdOrFunc:*, elementNumber:int = 0 ):IModule;
		function get snapshotSource():IBitmapDrawable;
		function clean():void;
	}
}