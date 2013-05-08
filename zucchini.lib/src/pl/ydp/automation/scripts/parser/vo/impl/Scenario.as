package pl.ydp.automation.scripts.parser.vo.impl
{
	
	import mx.collections.ArrayCollection;
	import mx.utils.StringUtil;
	
	import pl.ydp.automation.scripts.parser.ParserConfig;
	import pl.ydp.automation.scripts.parser.vo.IScenario;

	/**
	 * Reprezentacja pojedynczego scenariusza skryptu
	 * składającego się z opisu oraz listy kroków.
	 */
	public class Scenario implements IScenario
	{
		private var _scenarioRE:RegExp = ParserConfig.SCENARIO_REGEXP;
		
		/**
		 * Zawartość scenariusza
		 */
		private var _source:String;
		/**
		 * Opis scenariusza do przetestowania.
		 */
		private var _description:String;
		/**
		 * Fragmenty scenariusza zawierające poszczególne zdania.
		 */
		private var _sentencesParts:Array;
		/**
		 * Lista obiektów typu Sentence (_sentencesParts zmapowane na obiekty).
		 */
		private var _sentences:Array;
		
		public function Scenario(source:String)
		{
			_source = source;
			parse();
		}
		
		private function parse():void
		{
			var scenarioParts:ArrayCollection = getScenarioParts();
			
			var scenarioPart:String = scenarioParts.removeItemAt(0) as String;
			_description = StringUtil.trim( getDescription(_source) );
			
			clearParts(scenarioParts);
			
			parseSentences(scenarioParts.toArray());
		}
		
		private function getScenarioParts():ArrayCollection
		{
			var parts:ArrayCollection = new ArrayCollection(
				_source.split(ParserConfig.SENTENCES_DELIMITER)
			);
			return parts;
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
				
				var sentence:String = ( sentencesParts[i] as String );
				var sentenceIsCorrect:Boolean = ( sentence.search(ParserConfig.SENTENCES_DELIMITER) != -1 );
				
				if( sentenceIsCorrect ){
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