package pl.ydp.automation.scripts.parser.vo
{
	/**
	 * API dostarczane przez pojedynczy skypt (funkcjonalność).
	 */
	public interface IFeature
	{
		/**
		 * Nazwa funkcjonalności.
		 */
		function get name():String;
		/**
		 * Lista obiektów reprezentujących scenariusze.
		 */
		function get scenarios():Array;
	}
}