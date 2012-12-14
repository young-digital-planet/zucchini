package pl.ydp.automation.scripts.parser.vo.impl
{
	
	import mx.collections.ArrayCollection;
	import mx.utils.StringUtil;
	
	import pl.ydp.automation.configuration.impl.scripts.parser.GherkinConfig;
	import pl.ydp.automation.scripts.parser.ParserConfig;
	import pl.ydp.automation.scripts.parser.ParserUtil;
	import pl.ydp.automation.scripts.parser.vo.IScenario;

	public class Scenario implements IScenario
	{
		private var _scenarioRE:RegExp = ParserConfig.SCENARIO_REGEXP;
		
		private var _source:String;
		private var _description:String;
		
		private var _sentencesParts:Array;
		private var _sentences:Array;
		
		public function Scenario(source:String)
		{
			_source = source;
			parse();
		}
		
		private function parse():void
		{
			var scenarioParts:ArrayCollection = new ArrayCollection(
				_source.split(ParserConfig.SENTENCES_DELIMITER)
			);
			var scenarioPart:String = scenarioParts.removeItemAt(0) as String;
			_description = StringUtil.trim( getDescription(_source) );
			
			clearParts(scenarioParts);
			
			parseSentences(scenarioParts.toArray());
		}
		
		private function getDescription(scenarioPart:String):String
		{
			_scenarioRE.lastIndex = 0;
			var scenarioResult = _scenarioRE.exec(scenarioPart);
			return scenarioResult[1];
		}
		
		private function parseSentences(sentencesParts:Array):void
		{
			_sentencesParts = sentencesParts;
			_sentences = new Array();
			for each(var sentencePart in sentencesParts){
				var sentence:Sentence = new Sentence(sentencePart);
				_sentences.push(sentence);
			}
		}
		
		private function clearParts(sentencesParts:ArrayCollection):void
		{
			for(var i:int = 0; i < sentencesParts.length; i++){
				if((sentencesParts[i] as String).search(ParserConfig.SENTENCES_DELIMITER) != -1){
					sentencesParts.removeItemAt(i);
				}
			}
		}

		public function get description():String
		{
			return _description;
		}

		public function get sentences():Array
		{
			return _sentences;
		}


	}
}