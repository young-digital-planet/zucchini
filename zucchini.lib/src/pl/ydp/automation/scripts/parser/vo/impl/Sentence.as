package pl.ydp.automation.scripts.parser.vo.impl
{
	import pl.ydp.automation.scripts.parser.vo.ISentence;

	public class Sentence implements ISentence
	{
		/**
		 * Zawartość zdania.
		 */
		private var _source:String;
		
		public function Sentence(source:String)
		{
			_source = source;
		}
		
		public function get source():String
		{
			return _source;
		}

	}
}