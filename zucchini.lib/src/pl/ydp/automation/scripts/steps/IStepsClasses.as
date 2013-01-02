package pl.ydp.automation.scripts.steps
{
	/**
	 * API dostarczające informacji o klasach
	 * implementujących kroki.
	 */
	public interface IStepsClasses
	{
		/**
		 * Lista klas kroków.
		 */
		function get classes():Array;
	}
}