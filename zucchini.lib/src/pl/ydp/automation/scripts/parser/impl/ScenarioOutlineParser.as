package pl.ydp.automation.scripts.parser.impl
{
	import mx.collections.ArrayCollection;
	import mx.messaging.channels.StreamingAMFChannel;
	import mx.utils.StringUtil;
	
	import pl.ydp.automation.scripts.parser.ParserConfig;
	import pl.ydp.automation.scripts.parser.ParserUtil;

	public class ScenarioOutlineParser
	{
		private var _outlineRE:RegExp = ParserConfig.SCENARIO_OUTLINE;
		
		private var _source:String;
		
		private var _scenariosSources:Array;
		
		/**
		 * Lista zestawów zmiennych do podstawienia.
		 * (każdy zestaw zawiera wartości dla nowego scenariusza).
		 * Np.:
		 * [
		 * 	{param1: value1, param2: value2, param3: value3},
		 * 	{param1: value1, param2: value2, param3: value3},
		 * 	{param1: value1, param2: value2, param3: value3},
		 * ]
		 */
		private var _parameters:Array;
		
		
		public function ScenarioOutlineParser( scenarioSource:String )
		{
			scenarioSource = ParserUtil.removeExtraSpaces(scenarioSource);
			_source = scenarioSource;
		}
		
		public function parse():void
		{
			var scenarioParts:ArrayCollection = getScenarioOutlineParts();
			
			var examplesSource:String = scenarioParts[2];
			parseExamples( examplesSource );
			
			var scenarioSource:String = scenarioParts[1];
			createScenarios( scenarioSource );
		}
		
		private function getScenarioOutlineParts():ArrayCollection
		{
			var parts:ArrayCollection = new ArrayCollection(
				_source.split(ParserConfig.SCENARIO_OUTLINE)
			);
			return parts;
		}
		
		private function parseExamples(examplesSource:String):void
		{
			var examplesLines:ArrayCollection = new ArrayCollection( getLinesFromSource( examplesSource ) );
			var paramsSource:String = examplesLines.removeItemAt(0) as String;
			var params:Array = getArrayFromLine( paramsSource );
			
			parseValues( params, examplesLines );
		}
		
		private function getLinesFromSource(examplesSource:String):Array
		{
			var lines:Array = ParserUtil.getArrayFromString( examplesSource, '\n' );
			return lines;
		}
		
		private function getArrayFromLine( paramsSource:String ):Array
		{
			var params:Array = ParserUtil.getArrayFromString( paramsSource, '|' );
			return params;
		}

		private function parseValues(params:Array, examplesLines:ArrayCollection):void
		{
			_parameters = [];
			
			for each( var line:String in examplesLines ){
				var values:Array = getArrayFromLine( line );
				var lineParams:Object = {};
				
				for( var i:int = 0; i < params.length; i++ ){
					var param:String = StringUtil.trim( params[i] );
					var value:String = StringUtil.trim( values[i] );
					lineParams[ param ] = value;
				}
				_parameters.push( lineParams );
			}
		}
		
		private function createScenarios( scenarioSource:String ):void
		{
			_scenariosSources = [];

			var scenarioIndex:int = 1;
			for each( var params:Object in _parameters ){
				
				var newScenarioSource:String = getScenarioSourceWithNewDescription( scenarioSource, scenarioIndex );
				
				for( var key:String in params ){
					
					var value:String = params[key]; 
					newScenarioSource = setValuesInScenario( newScenarioSource, key, value );
				}
				_scenariosSources.push( newScenarioSource );
				
				scenarioIndex++;
			}
		}
		
		private function getScenarioSourceWithNewDescription( scenarioSource:String, scenarioIndex:int ):String
		{
			var newSource:String = '( ' + scenarioIndex.toString() + ' ) ' + scenarioSource;
			return newSource;
		}
		
		private function setValuesInScenario( scenarioSource:String, key:String, value:String ):String
		{
			var patternStr:RegExp =  new RegExp( '<' + key + '>', 'g');
			var valueStr:String = '"' + value + '"';
			var newScenarioSource = scenarioSource.replace( patternStr, valueStr );
			return newScenarioSource;
		}
		
		public function get scenariosSources():Array
		{
			return _scenariosSources;
		}


	}
}