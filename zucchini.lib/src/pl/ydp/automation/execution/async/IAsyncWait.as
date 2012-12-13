package pl.ydp.automation.execution.async
{
	public interface IAsyncWait
	{
		/**
		 * Zakończenie operacji asynchronicznej sukcesem.
		 */
		function success( ... any ):void;
		/**
		 * Zakończenie operacji asynchronicznej błędem. Akceptuje opcjonalnie
		 * obiekt, który na wołaniu toString() zwróci komunikat do wyśwetlenia.
		 * Np. Error lub ErrorEvent.
		 */
		function failure( ... any ):void;
	}
}