package pl.ydp.automation.execution.structure.impl
{
	import flash.events.Event;
	
	import org.osflash.signals.Signal;
	
	import pl.ydp.automation.execution.structure.IStructureElementDescriptor;
	
	public class ButtonDescriptor implements IStructureElementDescriptor
	{
		public function ButtonDescriptor()
		{
		}
		
		public function get children():*
		{
			return null;
		}
		
		public function getElementById(id:String):*
		{
			return null;
		}
		
		public function dispatchEventFromElement(event:Event):void
		{
			// TODO Auto Generated method stub
			
		}
		
		public function get stepCompleted():Signal
		{
			// TODO Auto Generated method stub
			return null;
		}
		
	}
}