package pl.ydp.automation.scripts.parser.vo
{
	public interface IScenario
	{
		/**
		 * Lista obiektów reprezentujących zdania.
		 */
		function get sentences():Array;
		function get description():String;
	}
}