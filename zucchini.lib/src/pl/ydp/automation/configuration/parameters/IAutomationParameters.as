package pl.ydp.automation.configuration.parameters
{
	import pl.ydp.automation.execution.structure.IStructure;
	import pl.ydp.automation.scripts.IScripts;
	import pl.ydp.automation.scripts.parser.IScriptParser;
	import pl.ydp.automation.scripts.steps.INamespaceVariables;
	import pl.ydp.automation.scripts.steps.IStepsClasses;

	/**
	 * Model przechowujący konfigurację środowiska testów
	 */
	public interface IAutomationParameters
	{
		/**
		 * Klasa z konfiguracją parsera skryptów 
		 * (określa wzorce wyszukiwania wewnątrz skyptów).
		 */
		function get parserConfigClass():Class;
		function get namespaceVariables():INamespaceVariables;
		function get steps():IStepsClasses;
		function get scripts():IScripts;
		function get structure():IStructure;	
		function get scriptParser():IScriptParser;
			
	}
}