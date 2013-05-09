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
		
		
		public function parse( source:String ):Array
		{
			var outlineSource = ParserUtil.removeExtraSpaces( source );
			var scenarioParts:ArrayCollection = getScenarioOutlineParts( outlineSource );
			
			var examplesSource:String = scenarioParts[2];
			var parameters:Array = parseExamples( examplesSource );
			
			var scenarioSource:String = scenarioParts[1];
			var scenariosSources:Array = createScenariosSources( scenarioSource, parameters );
			
			return scenariosSources;
		}
		
		
		private function getScenarioOutlineParts( source:String ):ArrayCollection
		{
			var parts:ArrayCollection = new ArrayCollection(
				source.split(ParserConfig.SCENARIO_OUTLINE)
			);
			return parts;
		}
		
		private function parseExamples(examplesSource:String):Array
		{
			var examplesLines:ArrayCollection = new ArrayCollection( getLinesFromSource( examplesSource ) );
			var paramsSource:String = examplesLines.removeItemAt(0) as String;
			var params:Array = getArrayFromLine( paramsSource );
			
			var parameters:Array = parseParameters( params, examplesLines );
			return parameters;
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
		private function parseParameters(params:Array, examplesLines:ArrayCollection):Array
		{
			var parameters:Array = [];
			
			for each( var line:String in examplesLines ){
				var values:Array = getArrayFromLine( line );
				var lineParams:Object = {};
				
				for( var i:int = 0; i < params.length; i++ ){
					var param:String = StringUtil.trim( params[i] );
					var value:String = StringUtil.trim( values[i] );
					lineParams[ param ] = value;
				}
				parameters.push( lineParams );
			}
			return parameters;
		}
		
		private function createScenariosSources( scenarioSource:String, parameters:Array ):Array
		{
			var scenariosSources:Array = [];

			var scenarioIndex:int = 1;
			for each( var params:Object in parameters ){
				
				var newScenarioSource:String = getScenarioSourceWithNewDescription( scenarioSource, scenarioIndex );
				
				for( var key:String in params ){
					
					var value:String = params[key]; 
					newScenarioSource = setValuesInScenario( newScenarioSource, key, value );
				}
				scenariosSources.push( newScenarioSource );
				
				scenarioIndex++;
			}
			return scenariosSources;
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
	}
}