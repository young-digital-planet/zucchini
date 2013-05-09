package pl.ydp.automation
{
	import org.osflash.signals.Signal;
	
	import pl.ydp.automation.execution.AutomationScript;
	import pl.ydp.automation.scripts.ScriptsManager;
	import pl.ydp.automation.scripts.ScriptsModel;
	import pl.ydp.automation.scripts.StepsManager;
	import pl.ydp.automation.scripts.parser.vo.IFeature;

	/**
	 * Silnik odpowiedzialny za przygotowanie testów.
	 */
	public class ScriptsEngine
	{
		[Inject] 
		public var scriptsManager:ScriptsManager;
		[Inject] 
		public var stepsManager:StepsManager;
		[Inject] 
		public var scriptsModel:ScriptsModel;
		
		private var _allScriptsAutomated:Signal = new Signal();
		
		public function ScriptsEngine()
		{
		}
		
		/**
		 * Proces przygotowania skryptów składa się z następujących części
		 * wykonywanych sekwencyjnie:
		 * 
		 * 1. Załadowanie skryptów
		 * 2. Sparsowanie skryptów (-> IFeature)
		 * 3. Zautomatyzowanie skryptów (-> IAutomationScript)
		 */
		public function prepareScripts():void
		{
			loadScripts();
		}
		
		/**
		 * 1. Załadowanie skryptów
		 */
		public function loadScripts():void
		{
			scriptsManager.allScriptsLoaded.add( onAllScriptsLoaded );
			scriptsManager.loadScripts();
		}
		
		private function onAllScriptsLoaded():void
		{
			parseScripts();
		}
		
		/**
		 * 2. Sparsowanie skryptów (-> IFeature)
		 */
		private function parseScripts():void
		{
			scriptsManager.allScriptsParsed.add( onAllScriptsParsed );
			scriptsManager.scriptParsed.add( onScriptParsed );
			scriptsManager.parseScripts();
		}
		
		private function onScriptParsed( feature:IFeature ):void
		{
			automateScript( feature );
		}
		
		//	STEPS MANAGER
		
		/**
		 * 3. Zautomatyzowanie skryptów (-> IAutomationScript)
		 */
		private function automateScript(feature:IFeature):void
		{
			var automationScript:AutomationScript = stepsManager.automateFeature(feature);
			scriptsModel.addAutomationScript( automationScript );
		} 
		
		private function onAllScriptsParsed():void
		{
			_allScriptsAutomated.dispatch();
		}

		public function get allScriptsAutomated():Signal
		{
			return _allScriptsAutomated;
		}
	}
}