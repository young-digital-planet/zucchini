package pl.ydp.automation.configuration
{
	import flash.events.Event;
	
	import org.osflash.signals.Signal;
	
	import pl.ydp.automation.scripts.IScripts;
	
	/**
	 * Klasa odpowiedzialna za obsługę wywołań 
	 * operacji niezbędnych  w początkowej fazie
	 * cyklu życia aplikacji (po konfiguracji kontekstu). 
	 */
	public class StartupOperations 
	{
		private var _operationsFinished:Signal = new Signal();
		
		[Inject]
		public var scripts:IScripts;
		
		public function StartupOperations()
		{
			super();
		}
		
		public function execute():void
		{
			initializeScripts();
			
		}
		private function initializeScripts():void
		{
			scripts.addEventListener( Event.COMPLETE, onComplete );
			scripts.initialize();
		}
		
		private function onComplete( e:Event ):void
		{
			finished();
		}

		private function finished():void
		{
			_operationsFinished.dispatch();
		}
		
		public function get operationsFinished():Signal
		{
			return _operationsFinished;
		}
	}
}