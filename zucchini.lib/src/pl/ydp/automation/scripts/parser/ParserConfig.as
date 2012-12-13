package pl.ydp.automation.scripts.parser
{
	import pl.ydp.automation.configuration.impl.scripts.parser.GherkinConfig;

	public class ParserConfig
	{
		private static var _config:Class = GherkinConfig;
		
		public function ParserConfig()
		{
			
		}
		
		public static function get FEATURE_REGEXP():*
		{
			return _config.FEATURE_REGEXP;
		}
		
		public static function get SCENARIOS_DELIMITER():*
		{
			return _config.SCENARIOS_DELIMITER;
		}
		
		public static function get SCENARIO_REGEXP():*
		{
			return _config.SCENARIO_REGEXP;
		}
		
		public static function get SENTENCES_DELIMITER():*
		{
			return _config.SENTENCES_DELIMITER;
		}
		
		
		
		public static function set configClass( parserConfigClass:Class ):void
		{
			_config = parserConfigClass;
		}
		
	}
}