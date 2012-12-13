package pl.ydp.automation.scripts.parser
{
	import pl.ydp.automation.scripts.IScriptSource;
	import pl.ydp.automation.scripts.parser.vo.IFeature;

	public interface IScriptParser
	{
		function parse( scriptSource:IScriptSource ):IFeature;
	}
}