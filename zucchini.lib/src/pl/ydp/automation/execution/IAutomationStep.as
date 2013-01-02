package pl.ydp.automation.execution
{
	import org.osflash.signals.Signal;
	
	import pl.ydp.automation.scripts.parser.vo.ISentence;

	/**
	 * API, które musi dostarczyć każdy krok.
	 */
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
		function get executionCompleted():Signal;
	}
}