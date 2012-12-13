package pl.ydp.automation.configuration.impl.parameters
{
	import pl.ydp.automation.configuration.impl.scripts.fs.FilesystemScripts;
	import pl.ydp.automation.configuration.impl.scripts.parser.GherkinConfig;
	import pl.ydp.automation.configuration.impl.scripts.steps.DefaultNamespaceVariables;
	import pl.ydp.automation.configuration.impl.scripts.steps.DefaultStepsClasses;
	import pl.ydp.automation.configuration.parameters.AutomationParameters;
	import pl.ydp.automation.execution.structure.impl.utopia.UtopiaStructureComponent;
	import pl.ydp.automation.scripts.parser.impl.ScriptParser;

	public class DefaultAutomationParameters extends AutomationParameters
	{
		public function DefaultAutomationParameters()
		{
			initParserConfig();
			initNamespaceVariables();
			initSteps();
			initScripts();
			initReportDestination();
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
		
		
		protected function initReportDestination():void
		{
//			_reportDestination = 
		}
		
		protected function initStructure():void
		{
			_structure = new UtopiaStructureComponent();
		}
		
		protected function initScriptParser():void
		{
			
			_scriptParser = new ScriptParser();
		}
		
	}
}