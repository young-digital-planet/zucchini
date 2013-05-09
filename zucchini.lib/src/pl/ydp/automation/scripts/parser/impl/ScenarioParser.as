package pl.ydp.automation.scripts.parser.impl
{
	import mx.collections.ArrayCollection;
	import mx.utils.StringUtil;
	
	import pl.ydp.automation.scripts.parser.ParserConfig;
	import pl.ydp.automation.scripts.parser.vo.impl.Scenario;
	import pl.ydp.automation.scripts.parser.vo.impl.Sentence;

	public class ScenarioParser
	{
		
		public function parse( source:String ):Scenario
		{
			var scenarioParts:ArrayCollection = getScenarioParts( source );
			var scenarioPart:String = scenarioParts.removeItemAt(0) as String;
			var description:String = StringUtil.trim( scenarioPart );
				
			clearParts(scenarioParts);
			
			var sentences:Array = parseSentences(scenarioParts.toArray());
			
			var scenario:Scenario = new Scenario( description, sentences );
			return scenario;
		}
		
		private function getScenarioParts( source ):ArrayCollection
		{
			var parts:ArrayCollection = new ArrayCollection(
				source.split(ParserConfig.SENTENCES_DELIMITER)
			);
			return parts;
		}
		
		private function parseSentences(sentencesParts:Array):Array
		{
			var sentences:Array = new Array();
			for each(var sentencePart in sentencesParts){
				var sentence:Sentence = new Sentence( sentencePart );
				sentences.push(sentence);
			}
			return sentences;
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
	}
}