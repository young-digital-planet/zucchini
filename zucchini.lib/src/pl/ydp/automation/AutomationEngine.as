package pl.ydp.automation
{
	import org.osflash.signals.Signal;
	
	import pl.ydp.automation.scripts.ScriptsModel;

	public class AutomationEngine
	{
		[Inject] 
		public var scriptEngine:ScriptsEngine;
		[Inject]
		public var executionEngine:ExecutionEngine;
		
		[Inject]
		public var scriptsModel:ScriptsModel;
		
		private var _allScriptsPrepared:Signal = new Signal(); 
		private var _automationCompleted:Signal = new Signal();
		
		public function AutomationEngine()
		{
			
		}
		
		
		/**
		 * Załadowanie, sparsowanie i zautomatyzowanie wszystkich skryptów
		 * (przygotowanie do uruchomienia).
		 */
		public function prepare():void
		{
			scriptEngine.allScriptsAutomated.addOnce( onAllScriptsAutomated );
			scriptEngine.prepareScripts();
		}
		
		private function onAllScriptsAutomated():void
		{
			_allScriptsPrepared.dispatch();
		}
		
		
		/**
		 * Uruchamia wykonanie wszystkich przygotowanych testów behawioralnych
		 */
		public function start():void
		{
			executionEngine.executionCompleted.addOnce( onExecutionCompleted );
			executionEngine.start();
		}
		
		private function onExecutionCompleted():void
		{
			_automationCompleted.dispatch();
		}

		public function get allScriptsPrepared():Signal
		{
			return _allScriptsPrepared;
		}

		public function get automationCompleted():Signal
		{
			return _automationCompleted;
		}
		
		
	}
}