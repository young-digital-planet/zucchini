package pl.ydp.automation.scripts
{
	import pl.ydp.automation.execution.AutomationScript;

	/**
	 * Model danych skryptów.
	 */
	public class ScriptsModel
	{
		private var _automationScripts:Object = {};
		
		private var _scriptsToPrepareNames:Array= [];
		private var _scriptsToExecuteNames:Array =[];
		
		public function ScriptsModel()
		{
			
		}
		
		
		public function addAutomationScript( automationScript:AutomationScript ):void
		{
			_automationScripts[automationScript.name] = automationScript;
		}
		
		public function getAutomationScript( scriptName:String ):AutomationScript
		{
			if( _automationScripts.hasOwnProperty(scriptName) ){
				return _automationScripts[scriptName];
			}
			return null;
		}

		
		
		
		public function get scriptsToPrepareNames():Array
		{
			return _scriptsToPrepareNames;
		}

		public function set scriptsToPrepareNames(value:Array):void
		{
			_scriptsToPrepareNames = value;
		}

		
		public function get scriptsToExecute():Array
		{
			var scripts:Array = [];
			

			if( _scriptsToExecuteNames.length != 0 ){ // lista zdefiniowana w ustawieniach
				
				for each( var name:String in _scriptsToExecuteNames ){
					scripts.push( getAutomationScript( name ) );
				}
				
			}else{
				
				for each( var script:AutomationScript in _automationScripts ){
					scripts.push( script );
				}
				
			}
			return scripts;
		}
		
		public function get scriptsToExecuteNames():Array
		{
			return _scriptsToExecuteNames;
		}

		public function set scriptsToExecuteNames(value:Array):void
		{
			_scriptsToExecuteNames = value;
		}


	}
}