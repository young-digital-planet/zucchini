package pl.ydp.automation.execution
{
	import org.osflash.signals.Signal;
	
	import pl.ydp.automation.execution.structure.IStructure;
	import pl.ydp.automation.scripts.parser.vo.ISentence;
	import pl.ydp.automation.scripts.parser.vo.impl.Sentence;

	public interface IAutomationStep
	{
		
		function get name():String;
		
		function get sentence():ISentence;
		
		/**
		 * Przekazanie zmiennych sparsowanych ze zdania
		 */
		function set variables( variables:Array ):void;

		/**
		 * Inicjalizacja kroku argumentami.
		 */
		function initialize( sentence:ISentence ):void;
		
		/**
		 * Wykonanie kroku. Krok może oczekiwać na operacje asynchroniczne.
		 * Po wykonywania kroku musi zostać wywołana funkcja onStepCompleted( result:StepResult ).
		 */
		function execute( scriptName:String ):void;
		
		/**
		 * Zamknięcie kroku. Wykonywane jest tylko jeżeli wcześniej zostało wykonane 
		 * execute. Dispose może być wykonane w wyniku minięcia timeout'u, przed zakończeniem
		 * operacji asynchronicznej. 
		 */ 
		function dispose():void;
		
		function get executionCompleted():Signal;
		
	}
}