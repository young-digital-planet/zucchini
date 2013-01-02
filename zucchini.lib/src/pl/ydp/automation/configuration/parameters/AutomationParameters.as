package pl.ydp.automation.configuration.parameters
{
	import pl.ydp.automation.execution.structure.IStructure;
	import pl.ydp.automation.scripts.IScripts;
	import pl.ydp.automation.scripts.parser.IScriptParser;
	import pl.ydp.automation.scripts.steps.INamespaceVariables;
	import pl.ydp.automation.scripts.steps.IStepsClasses;

	/**
	 * Klasa bazowa dla implementacji klasy z parametrami aplikacji.
	 * Dostarcza settery i gettery.
	 */
	public class AutomationParameters implements IAutomationParameters
	{
		protected var _parserConfigClass:Class;
		protected var _namespaceVariables:INamespaceVariables;
		protected var _steps:IStepsClasses;
		protected var _scripts:IScripts;
		protected var _reportDestination:*;
		protected var _structure:IStructure;
		protected var _scriptParser:IScriptParser;
		
		
		public function AutomationParameters()
		{
			
		}
		

		public function get parserConfigClass():Class
		{
			return _parserConfigClass;
		}

		public function set parserConfigClass(value:Class):void
		{
			_parserConfigClass = value;
		}

		
		public function get namespaceVariables():INamespaceVariables
		{
			return _namespaceVariables;
		}

		public function set namespaceVariables(value:INamespaceVariables):void
		{
			_namespaceVariables = value;
		}

		public function get steps():IStepsClasses
		{
			return _steps;
		}

		public function set steps(value:IStepsClasses):void
		{
			_steps = value;
		}

		public function get scripts():IScripts
		{
			return _scripts;
		}

		public function set scripts(value:IScripts):void
		{
			_scripts = value;
		}

		public function get structure():IStructure
		{
			return _structure;
		}

		public function set structure(value:IStructure):void
		{
			_structure = value;
		}

		public function get scriptParser():IScriptParser
		{
			return _scriptParser;
		}

		public function set scriptParser(value:IScriptParser):void
		{
			_scriptParser = value;
		}


	}
}