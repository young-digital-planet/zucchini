package pl.ydp.automation.scripts.parser.impl
{
	import pl.ydp.automation.scripts.IScriptSource;
	import pl.ydp.automation.scripts.parser.IScriptParser;
	import pl.ydp.automation.scripts.parser.ParserUtil;
	import pl.ydp.automation.scripts.parser.vo.IFeature;
	import pl.ydp.automation.scripts.parser.vo.impl.Feature;

	public class ScriptParser implements IScriptParser
	{
	
		public function ScriptParser()
		{
			
		}
		
		public function parse(scriptSource:IScriptSource):IFeature
		{
			var scriptContent:String = ParserUtil.removeExtraSpaces(scriptSource.content);
			var feature:IFeature = new Feature(scriptSource.name, scriptContent);
			return feature;
		}
		
	}
}