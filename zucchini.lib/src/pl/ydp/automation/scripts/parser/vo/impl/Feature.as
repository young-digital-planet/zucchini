package pl.ydp.automation.scripts.parser.vo.impl
{
	
	import mx.collections.ArrayCollection;
	import mx.utils.StringUtil;
	
	import pl.ydp.automation.configuration.impl.scripts.parser.GherkinConfig;
	import pl.ydp.automation.execution.AutomationScript;
	import pl.ydp.automation.scripts.parser.ParserConfig;
	import pl.ydp.automation.scripts.parser.vo.IFeature;
	import pl.ydp.automation.scripts.parser.impl.ScenarioOutlineParser;

	/**
	 * Reprezentacja pojedynczego skryptu składającego się z opisu
	 * oraz listy scenariuszy.
	 */
	public class Feature implements IFeature
	{
		
		private var _featureRE:RegExp = ParserConfig.FEATURE_REGEXP;
		private var _outlineRE:RegExp = ParserConfig.SCENARIO_OUTLINE;
		
		/**
		 * Nazwa funkcjonalności, tożsama z nazwą pliku.
		 */
		private var _name:String;
		
		/**
		 * Zawartość skryptu.
		 */
		private var _source:String;
		/**
		 * Opis funkcjonalności do przetestowania.
		 */
		private var _decription:String;
		/**
		 * Lista obiektów typu Scenario (_scenariosParts zmapowane na obiekty).
		 */
		private var _scenarios:Array;
		
		
		public function Feature(name:String, source:String)
		{
			_name = name;
			_source = source;
			parse();
		}
		
		private function parse():void
		{
			var scriptParts:ArrayCollection = getScriptParts();
			
			var featurePart:String = scriptParts.removeItemAt(0) as String;
			_decription = getDescription( featurePart );
			
			var scenariosSources:Array = getScenariosFromParts( scriptParts.toArray() );
			
			parseScenarios( scenariosSources );
		}
		
		private function getScriptParts():ArrayCollection
		{
			var parts:ArrayCollection = new ArrayCollection(
				_source.split(ParserConfig.SCENARIOS_DELIMITER)
			);
			return parts;
		}
		
		private function getDescription(featurePart:String):String
		{
			_featureRE.lastIndex = 0;
			var featureResult = _featureRE.exec(featurePart);
			var description:String = StringUtil.trim( featureResult[1] );
			return description;
		}
		
		private function getScenariosFromParts( scriptParts:Array):Array
		{
			var scenariosSources:Array = [];
			
			for each( var scenarioSource:String in scriptParts ){
				var scenariosTmp:Array;
				if( isScenarioOutline( scenarioSource ) ){
					scenariosTmp = getScenariosFromOutline( scenarioSource );
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
		
		private function getScenariosFromOutline(scenarioSource:String):Array
		{
			var scenarioOutline:ScenarioOutlineParser = new ScenarioOutlineParser( scenarioSource );
			scenarioOutline.parse();
			return scenarioOutline.scenariosSources;
		}
		
		
		
		private function parseScenarios(scenariosSources:Array):void
		{
			_scenarios = new Array();
			for each(var scenarioContent:String in scenariosSources){
				var scenario:Scenario = new Scenario(scenarioContent);
				_scenarios.push(scenario);
			}
		}

		public function get decription():String
		{
			return _decription;
		}

		public function get scenarios():Array
		{
			return _scenarios;
		}

		public function get name():String
		{
			return _name;
		}

	}
}