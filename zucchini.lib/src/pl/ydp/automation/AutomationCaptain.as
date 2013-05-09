package pl.ydp.automation
{
	import org.osflash.signals.Signal;
	
	import pl.ydp.automation.configuration.context.IAutomationAppContext;
	import pl.ydp.automation.configuration.impl.context.DefaultAutomationAppContext;
	import pl.ydp.automation.configuration.impl.parameters.DefaultAutomationParameters;
	import pl.ydp.automation.configuration.parameters.IAutomationParameters;
	import pl.ydp.automation.configuration.settings.ISettings;
	import pl.ydp.automation.configuration.settings.SettingsGateway;
	import pl.ydp.automation.execution.structure.IStructure;

	/**
	 * Dostarcza niezbędne API do konfiguracji oraz zarządzania 
	 * całym procesem testowania.
	 * Jest najwyższym punktem biblioteki - korzystanie z biblioteki 
	 * powinno odbywać się za pośrednictwem tylko tej klasy.
	 */
	public class AutomationCaptain
	{
		
		private var _parameters:IAutomationParameters;
		private var _context:IAutomationAppContext;
		
		private var _settingsGateway:SettingsGateway;
		
		private var _engine:AutomationEngine;
		
		private var _configuratingCompleted:Signal = new Signal();
		private var _preparingCompleted:Signal = new Signal();
		private var _completed:Signal = new Signal();
		
		
		public function AutomationCaptain()
		{
			_settingsGateway = new SettingsGateway();
		}

		/**
		 * Sygnał potwierdzający zakończenie procesu testowania.
		 */
		public function get completed():Signal
		{
			return _completed;
		}

		/**
		 * Startowa konfiguracja środowiska wykonania testów.
		 * Głównie obiekty przeznaczone do wtryskiwania w klasach biblioteki.
		 */
		public function configure():void
		{
			if( _parameters == null ){
				_parameters = new DefaultAutomationParameters();
			}
			if( _context == null ){
				_context = new DefaultAutomationAppContext();
			}
			
			_context.settingsGateway = _settingsGateway;
			_context.parameters = _parameters;
			_context.contextCreated.addOnce( onContextCreated );
			_context.startup();
		}

		private function onContextCreated():void
		{
			_engine = _context.engine;
			
			_configuratingCompleted.dispatch();
		}
		
		/**
		 * Przygotowanie skryptów do uruchomienia.
		 */
		public function prepare():void
		{
			_engine.allScriptsPrepared.addOnce( onAllScriptsPrepared );
			_engine.prepare();
		}
		
		private function onAllScriptsPrepared():void
		{
			_preparingCompleted.dispatch();
		}
		
		
		/**
		 * Uruchomienie procesu testowania (wykonywanie i raportowanie).
		 */
		public function start():void
		{
			_engine.automationCompleted.addOnce( onAutomationCompleted );
			_engine.start();
		}
		
		private function onAutomationCompleted():void
		{
			_completed.dispatch();
		}
		
		
		public function set parameters( parameters:IAutomationParameters ):void
		{
			_parameters = parameters;
		}
		
		public function set context( appContext:IAutomationAppContext ):void
		{
			_context = appContext;
		}
		
		public function get configuratingCompleted():Signal
		{
			return _configuratingCompleted;
		}

		public function get preparingCompleted():Signal
		{
			return _preparingCompleted;
		}

		public function set engine(value:AutomationEngine):void
		{
			_engine = value;
		}
		
		public function get structure():IStructure
		{
			return _context.structure;
		}
		
		public function get settings():SettingsGateway
		{
			return _settingsGateway;
		}
		
		public function setSettings( value:ISettings ):void
		{
			_settingsGateway.settings = value;
		}
	}
}