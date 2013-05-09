package pl.ydp.automation.scripts.parser.impl
{
	import mx.collections.ArrayCollection;
	
	import pl.ydp.automation.scripts.IScriptSource;
	import pl.ydp.automation.scripts.parser.IScriptParser;
	import pl.ydp.automation.scripts.parser.ParserConfig;
	import pl.ydp.automation.scripts.parser.ParserUtil;
	import pl.ydp.automation.scripts.parser.vo.IFeature;
	import pl.ydp.automation.scripts.parser.vo.impl.Feature;

	/**
	 * Parser skryptów zawierających instrukcje testów.
	 */
	public class ScriptParser implements IScriptParser
	{
		private var _featureParser:FeatureParser;
		
		
		public function ScriptParser()
		{
			initParser();
		}
		
		private function initParser():void
		{
			_featureParser = new FeatureParser();
		}
		
		public function parse(scriptSource:IScriptSource):IFeature
		{
			var scriptContent:String = ParserUtil.removeExtraSpaces(scriptSource.content);
			
			var features:ArrayCollection = getFeaturesFromFileSource( scriptContent );
			var feature:Feature = _featureParser.parse( scriptSource.name, features[1] );
			return feature;
		}
		
		private function getFeaturesFromFileSource( source ):ArrayCollection
		{
			var parts:ArrayCollection = new ArrayCollection(
				source.split(ParserConfig.FEATURE_DELIMITER)
			);
			return parts;
		}
		
	}
}