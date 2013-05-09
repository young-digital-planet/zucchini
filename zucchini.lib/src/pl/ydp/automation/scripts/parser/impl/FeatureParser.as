package pl.ydp.automation.scripts.parser.impl
{
	import mx.collections.ArrayCollection;
	import mx.utils.StringUtil;
	
	import pl.ydp.automation.scripts.parser.ParserConfig;
	import pl.ydp.automation.scripts.parser.vo.impl.Feature;
	import pl.ydp.automation.scripts.parser.vo.impl.Scenario;

	public class FeatureParser
	{
		private var _scenarioParser:ScenarioParser;
		private var _scenarioOutlineParser:ScenarioOutlineParser;
		
		private var _outlineRE:RegExp = ParserConfig.SCENARIO_OUTLINE;
		
		public function FeatureParser()
		{
			initParsers();
		}
		
		private function initParsers():void
		{
			_scenarioParser = new ScenarioParser();	
			_scenarioOutlineParser = new ScenarioOutlineParser();
		}
		
		public function parse( name:String, source:String ):Feature
		{
			var scriptParts:ArrayCollection = getScriptParts( source );
			var featurePart:String = scriptParts.removeItemAt(0) as String;
			var description =  StringUtil.trim( featurePart );
			
			var scenariosSources:Array = getScenariosFromParts( scriptParts.toArray() );
			var scenarios:Array = parseScenarios( scenariosSources );
			
			var feature:Feature = new Feature( name, description, scenarios );
			return feature;
		}
		
		private function getScriptParts( source:String ):ArrayCollection
		{
			var parts:ArrayCollection = new ArrayCollection(
				source.split(ParserConfig.SCENARIOS_DELIMITER)
			);
			return parts;
		}
		
		private function getScenariosFromParts( scriptParts:Array):Array
		{
			var scenariosSources:Array = [];
			
			for each( var scenarioSource:String in scriptParts ){
				var scenariosTmp:Array;
				if( isScenarioOutline( scenarioSource ) ){
					scenariosTmp = getScenariosSourcesFromOutline( scenarioSource );
				}else{
					scenariosTmp = [scenarioSource];
				}
				scenariosSources = scenariosSources.concat( scenariosTmp );
			}
			return scenariosSources;
		}
		
		private function isScenarioOutline(scenarioSource:String):Boolean
		{
			var isOutline:Boolean = _outlineRE.test( scenarioSource );
			return isOutline;
		}	
		
		private function getScenariosSourcesFromOutline(scenarioSource:String):Array
		{
			var scenariosSources:Array = _scenarioOutlineParser.parse( scenarioSource );
			return scenariosSources;
		}
		
		private function parseScenarios(scenariosSources:Array):Array
		{
			var scenarios = new Array();
			for each(var scenarioContent:String in scenariosSources){
				
				var scenario:Scenario = _scenarioParser.parse( scenarioContent );
				scenarios.push(scenario);
			}
			return scenarios;
		}
	}
}