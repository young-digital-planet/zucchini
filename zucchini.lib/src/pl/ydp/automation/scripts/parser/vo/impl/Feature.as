package pl.ydp.automation.scripts.parser.vo.impl
{
	
	import mx.collections.ArrayCollection;
	import mx.utils.StringUtil;
	
	import pl.ydp.automation.configuration.impl.scripts.parser.GherkinConfig;
	import pl.ydp.automation.execution.AutomationScript;
	import pl.ydp.automation.scripts.parser.ParserConfig;
	import pl.ydp.automation.scripts.parser.vo.IFeature;

	public class Feature implements IFeature
	{
		private var _featureRE:RegExp = ParserConfig.FEATURE_REGEXP;
	
		private var _name:String;
		
		private var _source:String;
		private var _decription:String;
		
		private var _scenariosParts:Array;
		private var _scenarios:Array;
		
		
		public function Feature(name:String, source:String)
		{
			_name = name;
			_source = source;
			parse();
		}
		
		private function parse():void
		{
			var scriptParts:ArrayCollection = new ArrayCollection(
				_source.split(ParserConfig.SCENARIOS_DELIMITER)
			);
			var featurePart:String = scriptParts.removeItemAt(0) as String;
			_decription = StringUtil.trim( getDescription( featurePart ) );
			
			parseScenarios(scriptParts.toArray());
		}
		private function getDescription(featurePart:String):String
		{
			_featureRE.lastIndex = 0;
			var featureResult = _featureRE.exec(featurePart);
			return featureResult[1];
		}
		
		private function parseScenarios(scenariosParts:Array):void
		{
			_scenariosParts = scenariosParts;
			_scenarios = new Array();
			for each(var scenarioPart:String in _scenariosParts){
				var scenario:Scenario = new Scenario(scenarioPart);
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