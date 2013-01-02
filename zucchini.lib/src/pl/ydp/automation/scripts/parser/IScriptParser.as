package pl.ydp.automation.scripts.parser
{
	import pl.ydp.automation.scripts.IScriptSource;
	import pl.ydp.automation.scripts.parser.vo.IFeature;

	/**
	 * API dostarczane przez parser skryptów.
	 */
	public interface IScriptParser
	{
		/**
		 * Parsowanie całego skryptu zawierającego instrukcje testów.
		 */
		function parse( scriptSource:IScriptSource ):IFeature;
	}
}