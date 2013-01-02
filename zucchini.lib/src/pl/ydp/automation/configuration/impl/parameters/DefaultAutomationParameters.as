package pl.ydp.automation.configuration.impl.parameters
{
	import pl.ydp.automation.configuration.impl.scripts.fs.FilesystemScripts;
	import pl.ydp.automation.configuration.impl.scripts.parser.GherkinConfig;
	import pl.ydp.automation.configuration.impl.scripts.steps.DefaultNamespaceVariables;
	import pl.ydp.automation.configuration.impl.scripts.steps.DefaultStepsClasses;
	import pl.ydp.automation.configuration.parameters.AutomationParameters;
	import pl.ydp.automation.scripts.parser.impl.ScriptParser;

	/** Domyślna implementacja parametrów przekazywanych do aplikacji.
	 */ 
	public class DefaultAutomationParameters extends AutomationParameters
	{
		public function DefaultAutomationParameters()
		{
			initParserConfig();
			initNamespaceVariables();
			initSteps();
			initScripts();
			initStructure();
			initScriptParser();
			
		}
		
		protected function initParserConfig():void
		{
			_parserConfigClass = GherkinConfig;
		}
		
	
		protected function initNamespaceVariables():void
		{
			_namespaceVariables = new DefaultNamespaceVariables();
		}
		
		protected function initSteps():void
		{
			_steps = new DefaultStepsClasses();
		}
		
		protected function initScripts():void
		{
			_scripts = new FilesystemScripts();
		}
		
		protected function initStructure():void
		{
//			_structure = new IStructure();
		}
		
		protected function initScriptParser():void
		{
			
			_scriptParser = new ScriptParser();
		}
		
	}
}