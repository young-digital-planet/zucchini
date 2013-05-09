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
		/**
		 * Opis scenariusza do przetestowania.
		 */
		private var _description:String;
		
		/**
		 * Lista obiektów typu Sentence (_sentencesParts zmapowane na obiekty).
		 */
		private var _sentences:Array;
		
		
		public function Scenario( parsedDescription:String, parsedSentences:Array )
		{
			_description = parsedDescription;
			_sentences = parsedSentences;
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